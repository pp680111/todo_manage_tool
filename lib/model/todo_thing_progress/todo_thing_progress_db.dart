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

  TodoThingProgressDb() : super(_openConnection());
  TodoThingProgressDb._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      return NativeDatabase(await DatabaseConstant.getSqliteFile(), logStatements: true);
    });
  }

  Future<List<TodoThingProgressDTO>> getProgress(int todoThingId) {
    return (select(todoThingProgress)..where((t) => t.todoThingId.equals(todoThingId)))
        .get()
        .then((result) => result.map((p) => TodoThingProgressDTO.mapToDTO(p)).toList());
  }

  Future<int> deleteById(int id) {
    return (delete(todoThingProgress)..where((t) => t.id.equals(id))).go();
  }
}