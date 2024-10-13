import 'package:drift/drift.dart';

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get parentCategoryId => text().nullable()();
  DateTimeColumn get createTime => dateTime()();
  DateTimeColumn get updateTime => dateTime()();

  // String? id;
  // String name;
  // String? parentCategoryId;
  // DateTime createTime;
  // DateTime updateTime;
  //
  // Category(this.id, this.name, this.parentCategoryId, this.createTime, this.updateTime);
  //
  // factory Category.def(String name) {
  //   return Category(null, name, null, DateTime.now(), DateTime.now());
  // }
}