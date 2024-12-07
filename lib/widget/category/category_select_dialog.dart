import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_manage/model/category/category_dto.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';

import '../../model/app_database.dart';

class CategorySelectDialog extends StatefulWidget {
  const CategorySelectDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategorySelectDialogState();
  }

}

class _CategorySelectDialogState extends State<CategorySelectDialog> {
  late PrefetchScrollListViewController<CategoryDTO> _controller;

  @override
  void initState() {
    super.initState();
    _controller = PrefetchScrollListViewController(dataProvider: _getData);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("选择分类"),

        content: Container(
          height: 300,
          width: 800,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              )
            ),
            child:  PrefetchScrollListView<CategoryDTO>(
                _controller,
                _itemBuilder),
          )
        )
    );
  }

  Future<List<CategoryDTO>> _getData(int pageIndex, int pageSize) async {
    return AppDatabase.instance.categoryDao.page(pageIndex, pageSize, null);
  }

  Widget _itemBuilder(CategoryDTO item) {
    return ListTile(
      title: Text(item.name),
      onTap: () => Navigator.pop(context, item),
    );
  }
}