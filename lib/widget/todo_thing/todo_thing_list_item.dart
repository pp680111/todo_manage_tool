import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';

import '../../model/todo_thing/todo_thing_dto.dart';

class TodoThingListItem extends StatelessWidget {
  TodoThingDTO item;
  void Function(BuildContext context, {TodoThingDTO? item}) onTap;

  TodoThingListItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(1),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        item.detail != null ? item.detail!.trim() : "",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        maxLines: 2,
      ),
      onTap: () {
        onTap(context, item: item);
      },
      trailing: _TrailingItem(deadLine: item.deadlineTime, id: item.id),
    );
  }
}

class _TrailingItem extends StatelessWidget {
  DateTime? deadLine;
  int id;

  _TrailingItem({this.deadLine, required this.id});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuAnchor(
          builder: (BuildContext context, MenuController controller, Widget? child) {
            return IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              }
            );
          },
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                AppDatabase.instance.todoThingDao.deleteById(id)
                  .then((_) {
                    PrefetchScrollListViewController controller = Provider.of<PrefetchScrollListViewController<TodoThingDTO>>(context, listen: false);
                    controller.refresh();
                  });
                // TODO 补充删除失败的处理
              },
              requestFocusOnHover: false,
              child: const Text("删除"),
            ),
          ],
        )
      ],
    );
  }

  String getDeadLineText() {
    if (deadLine == null) {
      return "";
    }

    if (deadLine!.isBefore(DateTime.now())) {
      return "已超时";
    }

    int secondsLeft = deadLine!.difference(DateTime.now()).inSeconds;
    if (secondsLeft < 60) {
      return "剩余${secondsLeft}秒";
    } else if (secondsLeft < 3600) {
      return "剩余${secondsLeft ~/ 60}分钟";
    } else if (secondsLeft < 86400) {
      return "剩余${secondsLeft ~/ 3600}小时";
    } else {
      return DateFormat("yyyy-MM-dd").format(deadLine!);
    }
  }
}