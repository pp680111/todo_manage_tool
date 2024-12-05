import 'package:drift/drift.dart';

import '../app_database.dart';
import 'category.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);
}