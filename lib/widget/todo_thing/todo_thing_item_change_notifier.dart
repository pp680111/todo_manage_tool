import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';

import '../../model/todo_thing/todo_thing_state.dart';

class TodoThingItemProvider extends ChangeNotifier {
  TodoThingItemProvider();

  TodoThingDTO getItem(int index) {
    String randomStr = List.generate(Random().nextInt(500),
            (index) => index).map((e) => e.toString()).join();

    TodoThingDTO dto = TodoThingDTO(id: index,
        title: "title $index",
        status: TodoThingState.NOT_START,
        detail: randomStr,
        createTime: DateTime.now(),
        updateTime: DateTime.now());

    return dto;
  }

  void onItemDelete() {
    notifyListeners();
  }
}