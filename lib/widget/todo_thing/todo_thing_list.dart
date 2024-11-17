import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_db.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';
import 'package:todo_manage/widget/search_bar_component.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_detail.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_item_change_notifier.dart';
import 'package:todo_manage/widget/todo_thing/todo_thing_list_item.dart';

import '../../model/todo_thing/todo_thing_dto.dart';

class TodoThingList extends StatefulWidget {
  final GlobalKey<_TodoThingListState> _state = GlobalKey();

  @override
  State<StatefulWidget> createState() {
    return _TodoThingListState();
  }

}

class _TodoThingListState extends State<TodoThingList> {
  final GlobalKey<_TodoThingListState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //     create: (context) => TodoThingItemProvider(),
    //     child: Column(
    //       children: [
    //         SearchBarComponent(onSearchChange: () {}, onAddButtonPress: (ctx) => _invokeEditPage(ctx)),
    //         Consumer<TodoThingItemProvider>(
    //           builder: (context, notifier, child) {
    //             return Expanded(
    //                 child: ListView.builder(
    //                   itemBuilder: (context, index) {
    //                     TodoThingDTO? dto = notifier.getItem(index);
    //                     if (dto == null) {
    //                       return null;
    //                     }
    //                     return TodoThingListItem(item: dto);
    //                   },
    //                 )
    //             );
    //           },
    //         )
    //       ],
    //     )
    // );
    return Column(
      children: [
        SearchBarComponent(onSearchChange: () {}, onAddButtonPress: (ctx) => _invokeEditPage(ctx)),
        Expanded(
          child: PrefetchScrollListView<TodoThingDTO>(
            dataProvider: (pageIndex, pageSize) => _getData(pageIndex, pageSize),
            itemBuilder: (i) => TodoThingListItem(item: i)
          )
        )
      ],
    );
  }

  Future<List<TodoThingDTO>> _getData(int pageIndex, int pageSize) async {
    return TodoThingDb.instance.page(pageIndex, pageSize);
  }

  void _invokeEditPage(BuildContext context) async {
    if (context != null) {
      await Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return TodoThingDetail();
      }));
    }
  }
}