import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/prefetch_scroll_list_view.dart';
import 'package:todo_manage/widget/todo_thing/refresh_notifier.dart';

import '../../model/todo_thing/todo_thing_dto.dart';
import '../../model/todo_thing/todo_thing_state.dart';

class TodoThingListItem extends StatefulWidget {
  TodoThingDTO item;
  void Function(BuildContext context, {TodoThingDTO? item}) onTap;

  TodoThingListItem({super.key, required this.item, required this.onTap});

  @override
  State<TodoThingListItem> createState() => _TodoThingListItemState();
}

class _TodoThingListItemState extends State<TodoThingListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(1),
      title: Text(
        widget.item.title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        widget.item.detail != null ? widget.item.detail!.trim() : "",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        maxLines: 2,
      ),
      onTap: () {
        widget.onTap(context, item: widget.item);
      },
      trailing: _TrailingItem(item: widget.item),
    );
  }
}

class _TrailingItem extends StatelessWidget {
  TodoThingDTO item;

  _TrailingItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: _getIcon(),
          onPressed: () {
            _switchStatus(context);
          },
        ),
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
                AppDatabase.instance.todoThingDao.deleteById(item.id)
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

  Icon _getIcon() {
    switch (item.status) {
      case TodoThingState.NOT_START:
      case TodoThingState.EXECUTING:
        return const Icon(
          Icons.circle_rounded,
          color: Colors.blueAccent,
        );
      case TodoThingState.FINISHED:
        return const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
        );
      case TodoThingState.EXPIRED:
        return const Icon(
          Icons.circle_rounded,
          color: Colors.red,
        );
    }
  }

  void _switchStatus(BuildContext ctx) {
    late TodoThingState nextState;

    switch (item.status) {
      case TodoThingState.NOT_START:
      case TodoThingState.EXECUTING:
        nextState = TodoThingState.FINISHED;
        break;
      case TodoThingState.FINISHED:
      default:
        nextState = TodoThingState.NOT_START;
        break;
    }

    AppDatabase.instance.todoThingDao.updateState(item.id, nextState)
        .then((_) {
          Provider.of<RefreshNotifier>(ctx, listen: false).doRefresh();
        })
        .catchError((e) {
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text("更新状态失败"), duration: Duration(milliseconds: 300)));
        });
  }
}
