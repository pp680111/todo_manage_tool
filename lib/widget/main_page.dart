import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_manage/widget/platform/windows/tray_event_listener.dart';
import 'package:todo_manage/widget/platform/windows/windows_event_listener.dart';
import 'package:todo_manage/widget/search_bar_component.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'category/category_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;


  @override
  void initState() {
    windowManager.addListener(WindowsEventListener(context));
    trayManager.addListener(TrayEventListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: _getDestinationList()
          ),Expanded(
            child: _switchContainerComponent()
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