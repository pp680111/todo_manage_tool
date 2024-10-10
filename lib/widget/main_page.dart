import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.calendar_month),
                label: Text("全部"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.folder),
                label: Text("分类"),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1,width: 1),
          Expanded(
            child: Column(
              children: [
                const Text('hello')
              ],
            ),
          )
        ],
      ),
    );
  }
}