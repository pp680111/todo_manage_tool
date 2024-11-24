import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_dto.dart';

import '../database.dart';

part 'todo_thing_progress_db.g.dart';

@DriftDatabase(tables: [TodoThingProgress])
class TodoThingProgressDb extends _$TodoThingProgressDb {
  static final TodoThingProgressDb instance = TodoThingProgressDb._internal();

  TodoThingProgressDb._internal() : super(DatabaseConstant.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      m.createAll();
    },
    onUpgrade: (m, from, to) async {
      m.createAll();
    },
  );

  Future<List<TodoThingProgressDTO>> getProgress(int todoThingId) {
    return (select(todoThingProgress)..where((t) => t.todoThingId.equals(todoThingId)))
        .get()
        .then((result) => result.map((p) => TodoThingProgressDTO.mapToDTO(p)).toList());
  }

  Future<int> deleteById(int id) {
    return (delete(todoThingProgress)..where((t) => t.id.equals(id))).go();
  }

  Future<int> insert(Map<String, dynamic> formMap) {
    try {
      _initDefValForFormMap(formMap);
      return into(todoThingProgress).insert(_buildTodoThingProgressCompanionFromMap(formMap));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void _initDefValForFormMap(Map<String, dynamic> formMap) {
    formMap['isFinished'] = false;
    formMap['createTime'] = DateTime.now();
    formMap['updateTime'] = DateTime.now();
  }

  TodoThingProgressCompanion _buildTodoThingProgressCompanionFromMap(Map<String, dynamic> formMap) {
    String? errMsg = _validateFromMap(formMap);
    if (errMsg != null) {
      throw Exception(errMsg);
    }

    return TodoThingProgressCompanion(
      todoThingId: Value(formMap['todoThingId']),
      content: Value(formMap['content']),
      isFinished: Value(formMap['isFinished']),
      createTime: Value(formMap['createTime']),
      updateTime: Value(formMap['updateTime'])
    );
  }

  String? _validateFromMap(Map<String, dynamic> formMap) {
    if (!formMap.containsKey('todoThingId')) {
      return '所属待办事项id为空';
    }
    if (formMap['todoThingId'] is! int) {
      return '所属待办事项id类型错误';
    }

    if (!formMap.containsKey('content')) {
      return '内容不得为空';
    }
    if (formMap['content'] is! String) {
      return '内容类型错误';
    }
  }
}