import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

import '../category/category_dto.dart';

class TodoThingDTOMapper {
  static TodoThingDTO mapToDTO(TodoThingData data) {
    TodoThingDTO ret = _map(data);
    _enhance([ret]);
    return ret;
  }

  static List<TodoThingDTO> mapToDTOList(List<TodoThingData> list) {
    if (list.isEmpty) {
      return [];
    }

    List<TodoThingDTO> ret = list.map((e) => _map(e)).toList();
    _enhance(ret);
    return ret;
  }

  static TodoThingDTO _map(TodoThingData data) {
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

  static void _enhance(List<TodoThingDTO> list) async {
    List<int> categoryIds = list.map((e) => e.categoryId).nonNulls.toList();
    if (categoryIds.isEmpty) {
      return;
    }

    List<CategoryDTO> categoryList = await AppDatabase.instance.categoryDao
        .selectById(categoryIds);
    Map<int, CategoryDTO> categoryMap = {};
    for (CategoryDTO item in categoryList) {
      categoryMap[item.id] = item;
    }

    for (var dto in list) {
      if (categoryMap.containsKey(dto.categoryId)) {
        dto.categoryName = categoryMap[dto.categoryId]!.name;
      }
    }
  }
}