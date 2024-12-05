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
      contentPadding: const EdgeInsets.all(1),
      title: Text(
        item.name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!(context, item: item);
        }
      },
      trailing: _TrailingItem(id: item.id),
    );
  }

}

class _TrailingItem extends StatelessWidget {
  int id;

  _TrailingItem({super.key, required this.id});

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