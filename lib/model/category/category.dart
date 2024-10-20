import 'package:drift/drift.dart';

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get parentCategoryId => text().nullable()();
  DateTimeColumn get createTime => dateTime()();
  DateTimeColumn get updateTime => dateTime()();
}