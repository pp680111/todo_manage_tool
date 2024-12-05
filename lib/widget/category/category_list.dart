import 'package:flutter/cupertino.dart';
import 'package:todo_manage/model/category/category_dto.dart';
import 'package:todo_manage/widget/category/category_list_item.dart';
import 'package:todo_manage/widget/search_bar_component.dart';

import '../../model/app_database.dart';
import '../prefetch_scroll_list_view.dart';
import 'category_detail.dart';

class CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListState();
  }
}

class _CategoryListState extends State<CategoryList> {
  late PrefetchScrollListViewController<CategoryDTO> _prefetchScrollListViewController;
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
          child: PrefetchScrollListView<CategoryDTO>(
             _prefetchScrollListViewController,
              (i) => CategoryListItem(item: i, onTap: invokeEditPage)
          )
        )
      ],
    );
  }

  Future<List<CategoryDTO>> _getData(int pageIndex, int pageSize) async {
    return AppDatabase.instance.categoryDao.page(pageIndex, pageSize, _searchKey);
  }

  void onSearchChange(String text) {
    _searchKey = text;
    _prefetchScrollListViewController.refresh();
  }

  void invokeEditPage(BuildContext ctx, {CategoryDTO? item}) async {
    bool? hasChange = await Navigator.push(ctx, CupertinoPageRoute(builder: (ctx) {
      return CategoryDetail(item: item);
    }));

    if (hasChange != null && hasChange) {
      _prefetchScrollListViewController.refresh();
    }
  }
}
