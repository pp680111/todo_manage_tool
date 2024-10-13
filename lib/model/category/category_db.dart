import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'category.dart';

part 'category_db.g.dart';

@DriftDatabase(tables: [Category])
class CategoryDb extends _$CategoryDb {
  CategoryDb() : super(_openConnection());

  CategoryDb.forTest(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}