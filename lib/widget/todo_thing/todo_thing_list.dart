import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list_item.dart';

class TodoThingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoThingListState();
  }

}

class _TodoThingListState extends State<TodoThingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _getItem(index);
      },
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
}