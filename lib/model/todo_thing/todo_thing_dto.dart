import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

class TodoThingDTO {
  int id;
  String title;
  String? detail;
  TodoThingState status;
  int? categoryId;
  String? categoryName;
  DateTime createTime;
  DateTime updateTime;
  DateTime? deadlineTime;

  TodoThingDTO({
    required this.id,
    required this.title,
    this.detail,
    required this.status,
    this.categoryId,
    this.categoryName,
    required this.createTime,
    required this.updateTime,
    this.deadlineTime,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['title'] = title;
    if (detail != null) {
      map['detail'] = detail;
    }
    map['status'] = status;
    if (categoryId != null) {
      map['categoryId'] = categoryId;
    }
    if (categoryName != null) {
      map['categoryName'] = categoryName;
    }
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    if (deadlineTime != null) {
      map['deadlineTime'] = deadlineTime;
    }

    return map;
  }
}