import 'package:drift/drift.dart';
import 'package:todo_manage/model/category/category_dto.dart';

import '../app_database.dart';
import 'category.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<int> deleteById(int id) {
    return (delete(category)..where((t) => t.id.equals(id))).go();
  }

  Future<List<CategoryDTO>> page(int pageIndex, int pageSize, String? searchKey) {
    SimpleSelectStatement<Category, CategoryData> statement = select(category);
    statement.limit(pageSize, offset:pageIndex >= 1 ? (pageIndex - 1) * pageSize : 0);

    if (searchKey != null && searchKey.isNotEmpty) {
      statement.where((t) => t.name.contains(searchKey));
    }

    statement.orderBy([(t) => OrderingTerm.desc(t.createTime)]);

    return statement.get()
        .then((result) => result.map((c) => _mapToDTO(c)).toList());

  }

  Future<int> insertOrUpdateFromMap(Map<String, dynamic> formMap) {
    if (!formMap.containsKey('id')) {
      _initDefValForFormMap(formMap);
      return into(category).insert(_buildCategoryCompanionFromMap(formMap));
    } else {
      return (update(category)..where((t) => t.id.equals(formMap['id']))).write(_buildCategoryCompanionFromMap(formMap));
    }
  }

  CategoryCompanion _buildCategoryCompanionFromMap(Map<String, dynamic> formMap) {
    String? errMsg = validateMapForm(formMap);
    if (errMsg != null) {
      throw Exception(errMsg);
    }

    return CategoryCompanion(
        name: Value(formMap['name']),
        parentCategoryId: Value(formMap['parentCategoryId']),
        createTime: Value(formMap['createTime']),
        updateTime: Value(formMap['updateTime'])
    );
  }

  String? validateMapForm(Map<String, dynamic> formMap) {
    // name
    if (!formMap.containsKey("name")) {
      return "名称不得为空";
    }
    if (formMap['name'] is! String) {
      return "名称参数值类型错误";
    }

    // createTime
    if (!formMap.containsKey("createTime")) {
      return "创建时间不得为空";
    }
    if (formMap['createTime'] is! DateTime) {
      return "创建时间参数值类型错误";
    }

    // updateTime
    if (!formMap.containsKey("updateTime")) {
      return "更新时间不得为空";
    }
    if (formMap['updateTime'] is! DateTime) {
      return "更新时间参数值类型错误";
    }

    return null;
  }

  void _initDefValForFormMap(Map<String, dynamic> formMap) {
    formMap['createTime'] = DateTime.now();
    formMap['updateTime'] = DateTime.now();
  }

  CategoryDTO _mapToDTO(CategoryData data) {
    return CategoryDTO(
      id: data.id,
      name: data.name,
      parentCategoryId: data.parentCategoryId,
      createTime: data.createTime,
      updateTime: data.updateTime
    );
  }
}