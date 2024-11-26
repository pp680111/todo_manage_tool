import 'package:flutter/cupertino.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';
import 'package:todo_manage/widget/search_bar_component.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_detail.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list_item.dart';

import '../../model/todo_thing/todo_thing_dto.dart';

class TodoThingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoThingListState();
  }
}

class _TodoThingListState extends State<TodoThingList> {
  late PrefetchScrollListViewController<TodoThingDTO> _prefetchScrollListViewController;
  String _searchKey = "";

  @override
  void initState() {
    super.initState();
    _prefetchScrollListViewController = PrefetchScrollListViewController(dataProvider: _getData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarComponent(onSearchChange: (text) => onSearchChange(text), onAddButtonPress: (ctx) => invokeEditPage(ctx)),
        Expanded(
          child: PrefetchScrollListView<TodoThingDTO>(
            _prefetchScrollListViewController,
            (i) => TodoThingListItem(item: i, onTap: invokeEditPage)
          )
        )
      ],
    );
  }

  Future<List<TodoThingDTO>> _getData(int pageIndex, int pageSize) async {
    return AppDatabase.instance.todoThingDao.page(pageIndex, pageSize, _searchKey);
  }

  void invokeEditPage(BuildContext context, {TodoThingDTO? item}) async {
    bool? hasChanged = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return TodoThingDetail(item: item);
    }));

    if (hasChanged != null && hasChanged) {
      _prefetchScrollListViewController.refresh();
    }
  }

  void onSearchChange(String text) {
    _searchKey = text;
    _prefetchScrollListViewController.refresh();
  }
}