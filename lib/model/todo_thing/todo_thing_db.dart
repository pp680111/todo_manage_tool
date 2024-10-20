
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';

part 'todo_thing_db.g.dart';

@DriftDatabase(tables: [TodoThing])
class TodoThingDb extends _$TodoThingDb {
  TodoThingDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}