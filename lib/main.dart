import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/desktop_pet/desktop_pet_page.dart';
import 'package:todo_manage/widget/desktop_pet/task_bubble_page.dart';
import 'package:todo_manage/widget/desktop_pet/task_bubble_window_service.dart';
import 'package:todo_manage/widget/main_page.dart';
import 'package:todo_manage/widget/platform/windows/tray_event_listener.dart';
import 'package:todo_manage/widget/platform/windows/tray_configuration.dart';
import 'package:todo_manage/widget/platform/windows/windows_configuration.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  final currentWindow = await WindowController.fromCurrentEngine();
  final windowArguments = _decodeWindowArguments(currentWindow.arguments);

  if (windowArguments['role'] == TaskBubbleWindowService.windowRole) {
    runApp(
      TaskBubbleApp(
        windowController: currentWindow,
        ownerWindowId: windowArguments['ownerWindowId'] as String,
        initialPosition: Offset(
          (windowArguments['x'] as num).toDouble(),
          (windowArguments['y'] as num).toDouble(),
        ),
      ),
    );
    return;
  }

  if (await FlutterSingleInstance().isFirstInstance()) {
    await WindowsConfiguration.initPetWindow();
    runApp(MyApp(windowController: currentWindow));
  } else {
    await FlutterSingleInstance().focus();
    exit(0);
  }
}

Map<String, dynamic> _decodeWindowArguments(String arguments) {
  if (arguments.isEmpty) return const {};
  try {
    return Map<String, dynamic>.from(jsonDecode(arguments) as Map);
  } on FormatException {
    return const {};
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.windowController});

  final WindowController windowController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  bool _petMode = true;
  bool _changingWindowMode = false;
  late final TrayEventListener _trayEventListener;
  late final TaskBubbleWindowService _taskBubbleWindow;

  @override
  void initState() {
    super.initState();
    _taskBubbleWindow = TaskBubbleWindowService(widget.windowController);
    unawaited(
      _taskBubbleWindow.initialize(onOpenMainWindow: _showMainWindow),
    );
    windowManager.addListener(this);
    _trayEventListener = TrayEventListener(onActivate: _showMainWindow);
    trayManager.addListener(_trayEventListener);
    TrayConfiguration.initTray(
      onShowMainWindow: _showMainWindow,
      onShowPet: _showPet,
      onExit: _exitApplication,
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    trayManager.removeListener(_trayEventListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo 桌面宠物',
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: _changingWindowMode
          ? const SizedBox.expand()
          : _petMode
              ? DesktopPetPage(
                  onOpenMainWindow: _showMainWindow,
                  onToggleTaskBubble: _taskBubbleWindow.toggle,
                )
              : const MainPage(),
    );
  }

  Future<void> _showMainWindow() async {
    if (_changingWindowMode) return;
    setState(() => _changingWindowMode = true);
    try {
      await _taskBubbleWindow.hide();
      await WindowsConfiguration.showMainWindow();
      await WidgetsBinding.instance.endOfFrame;
      if (mounted) {
        setState(() {
          _petMode = false;
          _changingWindowMode = false;
        });
      }
    } finally {
      if (mounted && _changingWindowMode) {
        setState(() => _changingWindowMode = false);
      }
    }
  }

  Future<void> _showPet() async {
    if (_changingWindowMode) return;
    setState(() => _changingWindowMode = true);
    try {
      await _taskBubbleWindow.hide();
      await WindowsConfiguration.showPetWindow();
      await WidgetsBinding.instance.endOfFrame;
      if (mounted) {
        setState(() {
          _petMode = true;
          _changingWindowMode = false;
        });
      }
    } finally {
      if (mounted && _changingWindowMode) {
        setState(() => _changingWindowMode = false);
      }
    }
  }

  Future<void> _closeMainWindow() async {
    if (_changingWindowMode) return;
    await windowManager.hide();
    try {
      await _showPet();
    } catch (_) {
      await windowManager.show();
      rethrow;
    }
  }

  Future<void> _exitApplication() async {
    await _taskBubbleWindow.hide();
    await windowManager.setPreventClose(false);
    trayManager.removeListener(_trayEventListener);
    await trayManager.destroy();
    await AppDatabase.instance.close();
    await windowManager.destroy();
    exit(0);
  }

  @override
  void onWindowClose() {
    if (_petMode) {
      unawaited(_exitApplication());
    } else {
      unawaited(_closeMainWindow());
    }
  }

  @override
  void onWindowMove() {
    if (!_petMode) return;
    unawaited(_taskBubbleWindow.followPet());
  }

  @override
  void onWindowMoved() {
    if (!_petMode) return;
    unawaited(WindowsConfiguration.rememberPetPosition());
    unawaited(_taskBubbleWindow.followPet());
  }

  @override
  void onWindowMinimize() {
    if (!_petMode) unawaited(_showPet());
  }
}
