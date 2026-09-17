import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list.dart';
import 'package:window_manager/window_manager.dart';

import 'category/category_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _AppTitleBar(),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                    selectedIndex: _selectedIndex,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    destinations: _getDestinationList()),
                Expanded(child: _switchContainerComponent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<NavigationRailDestination> _getDestinationList() {
    return const [
      NavigationRailDestination(
        icon: Icon(Icons.calendar_month),
        label: Text("全部"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.folder),
        label: Text("分类"),
      ),
    ];
  }

  Widget _switchContainerComponent() {
    return switch (_selectedIndex) {
      0 => TodoThingList(),
      1 => CategoryList(),
      int() => throw UnimplementedError(),
    };
  }
}

class _AppTitleBar extends StatefulWidget {
  const _AppTitleBar();

  @override
  State<_AppTitleBar> createState() => _AppTitleBarState();
}

class _AppTitleBarState extends State<_AppTitleBar> with WindowListener {
  bool _maximized = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    unawaited(_refreshMaximized());
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    if (mounted) setState(() => _maximized = true);
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) setState(() => _maximized = false);
  }

  Future<void> _refreshMaximized() async {
    final maximized = await windowManager.isMaximized();
    if (mounted && maximized != _maximized) {
      setState(() => _maximized = maximized);
    }
  }

  Future<void> _toggleMaximize() async {
    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (_) => windowManager.startDragging(),
              onDoubleTap: _toggleMaximize,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'TODO',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
          _CaptionButton(
            tooltip: '最小化',
            icon: Icons.minimize_rounded,
            onPressed: windowManager.minimize,
          ),
          _CaptionButton(
            tooltip: _maximized ? '还原' : '最大化',
            icon: _maximized
                ? Icons.filter_none_rounded
                : Icons.crop_square_rounded,
            onPressed: _toggleMaximize,
          ),
          _CaptionButton(
            tooltip: '关闭',
            icon: Icons.close_rounded,
            hoverColor: const Color(0xffe81123),
            onPressed: windowManager.close,
          ),
        ],
      ),
    );
  }
}

class _CaptionButton extends StatelessWidget {
  const _CaptionButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.hoverColor = const Color(0x1a000000),
  });

  final String tooltip;
  final IconData icon;
  final Future<void> Function() onPressed;
  final Color hoverColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          hoverColor: hoverColor,
          onTap: () => unawaited(onPressed()),
          child: SizedBox(
            width: 44,
            child: Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
