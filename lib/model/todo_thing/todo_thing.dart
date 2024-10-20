import 'package:drift/drift.dart';

class TodoThing extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get detail => text().nullable()();
  IntColumn get status => integer()();
  IntColumn get categoryId => integer().nullable()();
  DateTimeColumn get createTime => dateTime()();
  DateTimeColumn get deadlineTime => dateTime().nullable()();
  DateTimeColumn get updateTime => dateTime()();
}