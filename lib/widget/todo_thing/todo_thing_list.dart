import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';
import 'package:todo_manage/widget/search_bar_component.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_detail.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list_item.dart';

class TodoThingList extends StatefulWidget {
  final GlobalKey<_TodoThingListState> _state = GlobalKey();

  @override
  State<StatefulWidget> createState() {
    return _TodoThingListState();
  }

}

class _TodoThingListState extends State<TodoThingList> {
  final GlobalKey<_TodoThingListState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarComponent(onSearchChange: () {}, onAddButtonPress: () => _invokeEditPage(context)),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _getItem(index);
            },
          )
        )
      ],
    );
  }

  Widget _getItem(int index) {
    String randomStr = List.generate(Random().nextInt(500),
            (index) => index).map((e) => e.toString()).join();

    TodoThingDTO dto = TodoThingDTO(id: index,
        title: "title $index",
        status: TodoThingState.NOT_START,
        detail: randomStr,
        createTime: DateTime.now(),
        updateTime: DateTime.now());
    return TodoThingListItem(item: dto);
  }

  void _invokeEditPage(BuildContext context) {
    if (context != null) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return TodoThingDetail();
      }));
    }
  }
}