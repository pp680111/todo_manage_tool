import 'package:drift/drift.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';

part 'todo_thing_dao.g.dart';

@DriftAccessor(tables: [TodoThing])
class TodoThingDao extends DatabaseAccessor<AppDatabase> with _$TodoThingDaoMixin {

  TodoThingDao(super.database);

}