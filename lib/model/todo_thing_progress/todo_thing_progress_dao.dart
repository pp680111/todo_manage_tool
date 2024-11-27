import 'package:drift/drift.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_dto.dart';

import '../app_database.dart';

part 'todo_thing_progress_dao.g.dart';

@DriftAccessor(tables: [TodoThingProgress])
class TodoThingProgressDao extends DatabaseAccessor<AppDatabase> with _$TodoThingProgressDaoMixin {
  TodoThingProgressDao(super.database);

  Future<List<TodoThingProgressDTO>> getProgress(int todoThingId) {
    SimpleSelectStatement<TodoThingProgress, TodoThingProgressData> statement = select(todoThingProgress);
    statement.where((t) => t.todoThingId.equals(todoThingId));
    statement.orderBy([(t) => OrderingTerm.asc(t.isFinished),
          (t) => OrderingTerm.asc(t.id)]);

    return statement.get()
        .then((result) => result.map((p) => _mapToDTO(p)).toList());
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

  Future<int> updateIsFinished(int id, bool isFinished) {
    return (update(todoThingProgress)..where((t) => t.id.equals(id))).write(TodoThingProgressCompanion(isFinished: Value(isFinished)));
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
    return null;
  }

  TodoThingProgressDTO _mapToDTO(TodoThingProgressData data) {
    return TodoThingProgressDTO(data.id, data.todoThingId,
        data.content, data.isFinished, data.createTime, data.updateTime);
  }
}