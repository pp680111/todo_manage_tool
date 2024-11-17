
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

part 'todo_thing_db.g.dart';

@DriftDatabase(tables: [TodoThing])
class TodoThingDb extends _$TodoThingDb {
  static final TodoThingDb instance = TodoThingDb._internal();

  TodoThingDb._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }

  Future<List<TodoThingDTO>> getAll() {
    return select(todoThing).get()
        .then((list) => list.map((e) => TodoThingDTO.mapToDTO(e)).toList());
  }

  Future<List<TodoThingDTO>> page(int pageIndex, int pageSize) {
    int start = (pageIndex <= 0 ? 0 : pageIndex - 1) * pageSize;
    return (select(todoThing)..limit(pageSize, offset: start)).get()
        .then((list) => list.map((e) => TodoThingDTO.mapToDTO(e)).toList());

  }

  // Future<int> insertFromDTO(TodoThingDTO dto) {
  //   return into(todoThing).insert(_buildTodoThingCompanionFromDTO(dto));
  // }

  Future insertOrUpdateFromMap(Map<String, dynamic> formMap) {
    if (!formMap.containsKey('id')) {
      _initDefValForFormMap(formMap);
      return into(todoThing).insert(_buildTodoThingCompanionFromMap(formMap));
    } else {
      return update(todoThing).replace(_buildTodoThingCompanionFromMap(formMap));
    }
  }

  TodoThingCompanion _buildTodoThingCompanionFromDTO(TodoThingDTO dto) {
    String? errMsg = _validateForm(dto);
    // TODO 怎么抛出错误?

    return TodoThingCompanion.insert(
      title: dto.title,
      status: dto.status.key,
      detail: Value.absentIfNull(dto.detail),
      categoryId: Value.absentIfNull(dto.categoryId),
      createTime: dto.createTime,
      updateTime: dto.updateTime,
      deadlineTime: Value.absentIfNull(dto.deadlineTime)
    );
  }

  TodoThingCompanion _buildTodoThingCompanionFromMap(Map<String, dynamic> formMap) {
    String? errMsg = _validateFormMap(formMap);
    // TODO 怎么抛出错误?

    return TodoThingCompanion.insert(
      title: formMap['title'],
      status: formMap['status'],
      detail: Value.absentIfNull(formMap['detail']),
      categoryId: Value.absentIfNull(formMap['categoryId']),
      createTime: formMap['createTime'],
      updateTime: formMap['updateTime'],
      deadlineTime: Value.absentIfNull(formMap['deadlineTime'])
    );
  }

  String? _validateForm(TodoThingDTO dto) {
  }

  String? _validateFormMap(Map<String, dynamic> formMap) {
    // title
    if (!formMap.containsKey('title')) {
      return '标题不得为空';
    }
    if (formMap['title'] is! String) {
      return '标题参数值类型错误';
    }

    // detail
    if (formMap['detail'] != null && formMap['detail'] is! String) {
      return '详情参数值类型错误';
    }

    // status
    if (formMap['status'] != null) {
      if (formMap['status'] is! int) {
        return '分类参数值类型错误';
      }

      try {
        TodoThingState.fromKey(formMap['status']);
      } catch (e) {
        return '分类参数枚举值错误';
      }
    }

    // categoryId
    if (formMap['categoryId'] != null) {
      if (formMap['categoryId'] is! int) {
        return '分类参数值类型错误';
      }
    }

    // createTime
    if (!formMap.containsKey('createTime')) {
      return '创建时间不得为空';
    }
    if (formMap['createTime'] is! DateTime) {
      return '创建时间参数值类型错误';
    }

    // updateTime
    if (!formMap.containsKey('updateTime')) {
      return '更新时间不得为空';
    }
    if (formMap['updateTime'] is! DateTime) {
      return '更新时间参数值类型错误';
    }

    // deadlineTime
    if (formMap['deadlineTime'] != null) {
      if (formMap['deadlineTime'] is! DateTime) {
        return '截止时间参数值类型错误';
      }
    }
  }

  void _initDefValForFormMap(Map<String, dynamic> formMap) {
    formMap['createTime'] = DateTime.now();
    formMap['updateTime'] = DateTime.now();
    formMap['status'] = TodoThingState.NOT_START.key;
  }
}