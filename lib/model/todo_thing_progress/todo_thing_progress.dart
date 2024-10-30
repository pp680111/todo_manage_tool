import 'package:drift/drift.dart';

class TodoThingProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get todoThingId => integer()();
  TextColumn get content => text().nullable()();
  BoolColumn get isFinished => boolean()();
  DateTimeColumn get createTime => dateTime()();
  DateTimeColumn get updateTime => dateTime()();

}