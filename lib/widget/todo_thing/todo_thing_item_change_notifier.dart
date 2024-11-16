import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_db.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_db.dart';

import '../../model/todo_thing/todo_thing_state.dart';

class TodoThingItemProvider extends ChangeNotifier {
  List<TodoThingDTO> _list = [];

  TodoThingItemProvider () {
    TodoThingDb.instance.getAll()
        .then((list) {
          _list.addAll(list);
          notifyListeners();
    });
  }

  TodoThingDTO? getItem(int index) {
    if (index < 0 || index >= _list.length) {
      return null;
    } else {
      return _list[index];
    }
  }

  void refresh() {
    notifyListeners();
  }

  void deleteItem() {
    notifyListeners();
  }
}