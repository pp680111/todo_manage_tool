import 'package:drift/drift.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

part 'todo_thing_dao.g.dart';

@DriftAccessor(tables: [TodoThing])
class TodoThingDao extends DatabaseAccessor<AppDatabase> with _$TodoThingDaoMixin {

  TodoThingDao(super.database);

  Future<List<TodoThingDTO>> page(int pageIndex, int pageSize, String? searchKey) {
    SimpleSelectStatement<TodoThing, TodoThingData> statement = select(todoThing);

    int start = (pageIndex <= 0 ? 0 : pageIndex - 1) * pageSize;
    statement.limit(pageSize, offset: start);

    if (searchKey != null && searchKey.isNotEmpty) {
      statement.where((t) => (t.title.like('%$searchKey%') | t.detail.like('%$searchKey%')));
    }

    statement.orderBy([(t) => OrderingTerm.asc(t.status), (t) => OrderingTerm.desc(t.createTime)]);

    return statement.get()
        .then((list) => list.map((e) => _mapToDTO(e)).toList());
  }

  TodoThingDTO _mapToDTO(TodoThingData data) {
    return TodoThingDTO(
      id: data.id,
      title: data.title,
      detail: data.detail,
      status: TodoThingState.fromKey(data.status),
      categoryId: data.categoryId,
      createTime: data.createTime,
      updateTime: data.updateTime,
      deadlineTime: data.deadlineTime
    );
  }

  Future insertOrUpdateFromMap(Map<String, dynamic> formMap) {
    try {
      if (!formMap.containsKey('id')) {
        _initDefValForFormMap(formMap);
        return into(todoThing).insert(_buildTodoThingCompanionFromMap(formMap));
      } else {
        return (update(todoThing)..where((t) => t.id.equals(formMap['id'])))
            .write(_buildTodoThingCompanionFromMap(formMap));
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<int> deleteById(int id) {
    return (delete(todoThing)..where((t) => t.id.equals(id))).go();
  }

  TodoThingCompanion _buildTodoThingCompanionFromMap(Map<String, dynamic> formMap) {
    String? errMsg = _validateFormMap(formMap);
    if (errMsg != null) {
      throw Exception(errMsg);
    }

    return TodoThingCompanion(
        title: Value(formMap['title']),
        status: Value((formMap['status'] as TodoThingState).key),
        detail: Value(formMap['detail']),
        categoryId: Value(formMap['categoryId']),
        createTime: Value(formMap['createTime']),
        updateTime: Value(formMap['updateTime']),
        deadlineTime: Value(formMap['deadlineTime'])
    );
  }

  String? _validateFormMap(Map<String, dynamic> formMap) {
    // title
    if (!formMap.containsKey('title')) {
      return '标题不得为空';
    }
    if (formMap['title'] is! String) {
      return '标题参数值类型错误';
    }

    // detail
    if (formMap['detail'] != null && formMap['detail'] is! String) {
      return '详情参数值类型错误';
    }

    // status
    if (!formMap.containsKey('status')) {
      return '分类不得为空';
    }
    if (formMap['status'] is! TodoThingState) {
      return '分类参数值类型错误';
    }

    // categoryId
    if (formMap['categoryId'] != null) {
      if (formMap['categoryId'] is! int) {
        return '分类参数值类型错误';
      }
    }

    // createTime
    if (!formMap.containsKey('createTime')) {
      return '创建时间不得为空';
    }
    if (formMap['createTime'] is! DateTime) {
      return '创建时间参数值类型错误';
    }

    // updateTime
    if (!formMap.containsKey('updateTime')) {
      return '更新时间不得为空';
    }
    if (formMap['updateTime'] is! DateTime) {
      return '更新时间参数值类型错误';
    }

    // deadlineTime
    if (formMap['deadlineTime'] != null) {
      if (formMap['deadlineTime'] is! DateTime) {
        return '截止时间参数值类型错误';
      }
    }
  }

  void _initDefValForFormMap(Map<String, dynamic> formMap) {
    formMap['createTime'] = DateTime.now();
    formMap['updateTime'] = DateTime.now();
    formMap['status'] = TodoThingState.NOT_START;
  }
}