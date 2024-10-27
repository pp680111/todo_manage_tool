import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/todo_thing/todo_thing_dto.dart';

class TodoThingListItem extends StatelessWidget {
  TodoThingDTO item;

  TodoThingListItem({required this.item});

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
        item.detail ?? "",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      trailing: _TrailingItem(deadLine: item.deadlineTime)
    );
  }

}

class _TrailingItem extends StatelessWidget {
  DateTime? deadLine;

  _TrailingItem({this.deadLine});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(getDeadLineText()),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.more_vert_outlined))
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