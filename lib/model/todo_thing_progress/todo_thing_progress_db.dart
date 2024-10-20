import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress.dart';

part 'todo_thing_progress_db.g.dart';

@DriftDatabase(tables: [TodoThingProgress])
class TodoThingProgressDb extends _$TodoThingProgressDb {
  TodoThingProgressDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}