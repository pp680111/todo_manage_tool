import 'package:drift/drift.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress.dart';

import '../app_database.dart';

part 'todo_thing_progress_dao.g.dart';

@DriftAccessor(tables: [TodoThingProgress])
class TodoThingProgressDao extends DatabaseAccessor<AppDatabase> with _$TodoThingProgressDaoMixin {
  TodoThingProgressDao(super.database);
}