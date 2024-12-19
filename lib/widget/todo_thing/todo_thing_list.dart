import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';
import 'package:todo_manage/widget/search_bar_component.dart';
import 'package:todo_manage/widget/todo_thing/filter_bar.dart';
import 'package:todo_manage/widget/todo_thing/refresh_notifier.dart';
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
  Map<String, dynamic> _listParams = {};
  bool _showFilter = false;

  @override
  void initState() {
    super.initState();
    _prefetchScrollListViewController = PrefetchScrollListViewController(dataProvider: _getData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => RefreshNotifier(),
      child: Column(
        children: [
          SearchBarComponent(
            onSearchChange: (text) => onSearchChange(text),
            onAddButtonPress: (ctx) => invokeEditPage(ctx),
            enableCustomFilter: true,
            onCustomFilterPress: (ctx) => _showFilterBar(ctx),
          ),
          if (_showFilter)
            FilterBar(onFilterChange: _onFilterChange),
          Expanded(
            child: PrefetchScrollListView<TodoThingDTO>(
                _prefetchScrollListViewController,
                    (i) => TodoThingListItem(item: i, onTap: invokeEditPage)
            )
          ),
          Consumer<RefreshNotifier>(
            builder: (ctx, value, child) {
              _prefetchScrollListViewController.refresh();
              return Container(
                height: 0,
              );
            }
          )
        ],
      ),
    );
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
    _listParams['searchKey'] = text;
    _prefetchScrollListViewController.refresh();
  }

  Future<List<TodoThingDTO>> _getData(int pageIndex, int pageSize) async {
    return AppDatabase.instance.todoThingDao.page(pageIndex, pageSize, _listParams);
  }

  void _showFilterBar(BuildContext ctx) {
    setState(() {
      if (_showFilter) {
        _listParams = {};
        _showFilter = false;
      } else {
        _showFilter = true;
      }
    });
  }

  void _onFilterChange(Map<String, dynamic> params) {
    _listParams = params;
    _prefetchScrollListViewController.refresh();
  }

}