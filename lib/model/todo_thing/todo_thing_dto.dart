import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

class TodoThingDTO {
  int id;
  String title;
  String? detail;
  TodoThingState status;
  int? categoryId;
  DateTime createTime;
  DateTime updateTime;
  DateTime? deadlineTime;

  TodoThingDTO({
    required this.id,
    required this.title,
    this.detail,
    required this.status,
    this.categoryId,
    required this.createTime,
    required this.updateTime,
    this.deadlineTime,
  });
}