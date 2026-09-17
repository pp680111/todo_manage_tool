import 'dart:async';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';
import 'package:todo_manage/widget/desktop_pet/task_bubble_window_service.dart';
import 'package:window_manager/window_manager.dart';

class TaskBubbleApp extends StatefulWidget {
  const TaskBubbleApp({
    super.key,
    required this.windowController,
    required this.ownerWindowId,
    required this.initialPosition,
    this.autoShow = true,
  });

  final WindowController windowController;
  final String ownerWindowId;
  final Offset initialPosition;

  /// Whether the window shows itself once configured. Prewarmed windows
  /// stay hidden until the owner window sends the show command.
  final bool autoShow;

  @override
  State<TaskBubbleApp> createState() => _TaskBubbleAppState();
}

class _TaskBubbleAppState extends State<TaskBubbleApp> with WindowListener {
  int _refreshGeneration = 0;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    unawaited(widget.windowController.setWindowMethodHandler(_handleMethod));
    unawaited(_configureWindow());
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowBlur() {
    unawaited(_hide(reason: TaskBubbleWindowService.hideReasonBlur));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今日未完成',
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: TaskBubblePage(
        key: ValueKey(_refreshGeneration),
        onOpenMainWindow: _openMainWindow,
      ),
    );
  }

  Future<void> _configureWindow() async {
    const options = WindowOptions(
      title: '今日未完成',
      size: TaskBubbleWindowService.bubbleSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.setAsFrameless();
      await windowManager.setAlwaysOnTop(true);
      await windowManager.setSkipTaskbar(true);
      await windowManager.setResizable(false);
      await windowManager.setHasShadow(false);
      await windowManager.setPosition(widget.initialPosition);
      if (widget.autoShow) {
        await windowManager.show();
        await windowManager.focus();
      }
    });
    await windowManager.setPreventClose(true);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case TaskBubbleWindowService.refreshMethod:
        if (mounted) {
          setState(() => _refreshGeneration++);
        }
        return null;
      case TaskBubbleWindowService.moveMethod:
        final arguments = Map<Object?, Object?>.from(call.arguments as Map);
        await windowManager.setPosition(
          Offset(
            (arguments['x'] as num).toDouble(),
            (arguments['y'] as num).toDouble(),
          ),
        );
        return null;
      default:
        throw MissingPluginException('Unknown window method: ${call.method}');
    }
  }

  Future<void> _hide({String? reason}) async {
    await widget.windowController.hide();
    await WindowController.fromWindowId(widget.ownerWindowId)
        .invokeMethod<void>(TaskBubbleWindowService.hiddenMethod, {
      if (reason != null) 'reason': reason,
    });
  }

  Future<void> _openMainWindow() async {
    await WindowController.fromWindowId(widget.ownerWindowId)
        .invokeMethod<void>(TaskBubbleWindowService.openMainMethod);
  }
}

class TaskBubblePage extends StatefulWidget {
  const TaskBubblePage({
    super.key,
    required this.onOpenMainWindow,
    this.taskLoader,
  });

  final Future<void> Function() onOpenMainWindow;
  final Future<List<TodoThingDTO>> Function()? taskLoader;

  @override
  State<TaskBubblePage> createState() => _TaskBubblePageState();
}

class _TaskBubblePageState extends State<TaskBubblePage> {
  late Future<List<TodoThingDTO>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: Colors.white.withValues(alpha: 0.98),
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.today_rounded, color: Color(0xff27866f)),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        '今日未完成',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: '刷新',
                      visualDensity: VisualDensity.compact,
                      onPressed: _reloadTasks,
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                    ),
                  ],
                ),
                const Divider(height: 12),
                Expanded(child: _buildTaskList()),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: widget.onOpenMainWindow,
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: const Text('查看全部任务'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return FutureBuilder<List<TodoThingDTO>>(
      future: _tasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _BubbleMessage(
            icon: Icons.error_outline_rounded,
            text: '任务加载失败',
            actionText: '重试',
            onAction: _reloadTasks,
          );
        }
        final tasks = snapshot.data ?? const <TodoThingDTO>[];
        if (tasks.isEmpty) {
          return const _BubbleMessage(
            icon: Icons.celebration_rounded,
            text: '今天的任务都完成啦',
          );
        }
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: tasks.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) => _buildTaskItem(tasks[index]),
        );
      },
    );
  }

  Widget _buildTaskItem(TodoThingDTO task) {
    final deadline = task.deadlineTime;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        tooltip: '标记为完成',
        icon: const Icon(Icons.radio_button_unchecked_rounded),
        color: const Color(0xff27866f),
        onPressed: () => _finishTask(task),
      ),
      title: Text(task.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: deadline == null
          ? null
          : Text(
              DateFormat('HH:mm').format(deadline),
              style: const TextStyle(color: Colors.grey),
            ),
      onTap: widget.onOpenMainWindow,
    );
  }

  Future<List<TodoThingDTO>> _loadTasks() {
    if (widget.taskLoader != null) return widget.taskLoader!();
    return AppDatabase.instance.todoThingDao.findTodayUnfinished(
      now: DateTime.now(),
    );
  }

  void _reloadTasks() {
    final refreshedTasks = _loadTasks();
    setState(() {
      _tasks = refreshedTasks;
    });
  }

  Future<void> _finishTask(TodoThingDTO task) async {
    await AppDatabase.instance.todoThingDao
        .updateState(task.id, TodoThingState.FINISHED);
    if (mounted) _reloadTasks();
  }
}

class _BubbleMessage extends StatelessWidget {
  const _BubbleMessage({
    required this.icon,
    required this.text,
    this.actionText,
    this.onAction,
  });

  final IconData icon;
  final String text;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 42, color: const Color(0xff66a995)),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(color: Colors.grey)),
          if (actionText != null)
            TextButton(onPressed: onAction, child: Text(actionText!)),
        ],
      ),
    );
  }
}
