import 'package:flutter/cupertino.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_db.dart';
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


  @override
  void initState() {
    super.initState();
    _prefetchScrollListViewController = PrefetchScrollListViewController(dataProvider: _getData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarComponent(onSearchChange: () {}, onAddButtonPress: (ctx) => _invokeEditPage(ctx)),
        Expanded(
          child: PrefetchScrollListView<TodoThingDTO>(
            _prefetchScrollListViewController,
            (i) => TodoThingListItem(item: i)
          )
        )
      ],
    );
  }

  Future<List<TodoThingDTO>> _getData(int pageIndex, int pageSize) async {
    return TodoThingDb.instance.page(pageIndex, pageSize);
  }

  void _invokeEditPage(BuildContext context) async {
    bool? hasChanged = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return TodoThingDetail();
    }));

    if (hasChanged != null && hasChanged) {
      _prefetchScrollListViewController.refresh();
    }
  }
}