import 'package:todo_manage/model/todo_thing/todo_thing_db.dart';
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

  TodoThingDTO.mapToDTO(TodoThingData data) :
      id = data.id,
      title = data.title,
      detail = data.detail,
      status = TodoThingState.fromKey(data.status),
      categoryId = data.categoryId,
      createTime = data.createTime,
      updateTime = data.updateTime,
      deadlineTime = data.deadlineTime;

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
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    if (deadlineTime != null) {
      map['deadlineTime'] = deadlineTime;
    }

    return map;
  }
}