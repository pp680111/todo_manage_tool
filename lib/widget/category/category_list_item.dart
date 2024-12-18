import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';

import '../../model/category/category_dto.dart';
import '../prefetch_scroll_list_view.dart';

class CategoryListItem extends StatelessWidget {
  CategoryDTO item;
  void Function(BuildContext context, {CategoryDTO? item})? onTap;

  CategoryListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 60,
      contentPadding: const EdgeInsets.only(left: 10, right: 5),
      title: Text(
        item.name,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () {
        _displayDetail(context);
      },
      trailing: _TrailingItem(id: item.id, displayDetail: _displayDetail),
    );
  }

  void _displayDetail(BuildContext context) {
    if (onTap != null) {
      onTap!(context, item: item);
    }
  }
}

class _TrailingItem extends StatelessWidget {
  int id;
  void Function(BuildContext ctx)? displayDetail;

  _TrailingItem({super.key, required this.id, this.displayDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuAnchor(
          builder: (context, controller, child) {
            return IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
            );
          },
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                AppDatabase.instance.categoryDao.deleteById(id)
                  .then((_) {
                    PrefetchScrollListViewController controller = Provider.of<PrefetchScrollListViewController<CategoryDTO>>(context, listen: false);
                    controller.refresh();
                  });
              },
              requestFocusOnHover: false,
              child: const Text("删除"),
            )
          ],
        )
      ],
    );
  }
}