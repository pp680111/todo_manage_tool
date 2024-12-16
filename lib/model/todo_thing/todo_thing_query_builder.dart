import 'package:drift/drift.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';

class TodoThingQueryBuilder {
  static SimpleSelectStatement<TodoThing, TodoThingData> buildStatement(Map<String, dynamic>? params) {
    SimpleSelectStatement<TodoThing, TodoThingData> statement = AppDatabase
        .instance.todoThingDao.select(AppDatabase.instance.todoThing);

    if (params == null) {
      return statement;
    }

    for (var entry in params.entries) {
      if (entry.value == null) {
        continue;
      }

      switch(entry.key) {
        case 'searchKey':
          statement.where((t) => t.title.like('%${entry.value}%'));
          break;
        case 'categoryId':
          statement.where((t) => t.categoryId.equals(entry.value));
          break;
        case 'status':
          statement.where((t) => t.status.equals(entry.value));
          break;
      }
    }

    _mapOrder(statement, params['order']);

    return statement;
  }

  static void _mapOrder(SimpleSelectStatement<TodoThing, TodoThingData> statement, dynamic order) {
    int orderKey = 0;
    if (order != null && order is int) {
      orderKey = order;
    }

    switch(orderKey) {
      case 0:
        statement.orderBy([(t) => OrderingTerm.asc(t.status), (t) => OrderingTerm.desc(t.createTime)]);
    }
  }
}