import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/todo_thing/progress/progress_nofifier.dart';

import '../../../model/todo_thing_progress/todo_thing_progress_dto.dart';

class ProgressItem extends StatelessWidget {
  TodoThingProgressDTO progress;

  ProgressItem(this.progress, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        progress.content,
        style: const TextStyle(
          fontSize: 14,
        ),
        maxLines: 10,
      ),
      trailing: _ProgressItemTrailing(progress),
    );
  }
}

class _ProgressItemTrailing extends StatefulWidget {
  TodoThingProgressDTO progress;

  _ProgressItemTrailing(this.progress);

  @override
  State<StatefulWidget> createState() {
    return _ProgressItemTrailingState();
  }
}

class _ProgressItemTrailingState extends State<_ProgressItemTrailing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: widget.progress.isFinished,
          onChanged: (value) {
            setState(() {
              widget.progress.isFinished = value!;
            });
          },
          visualDensity: VisualDensity.comfortable,
        ),
        IconButton(
          onPressed: () {
            AppDatabase.instance.todoThingProgressDao.deleteById(widget.progress.id)
              .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("删除成功"), duration: Duration(milliseconds: 500)));
                ProgressNotifier progressNotifier = Provider.of<ProgressNotifier>(context, listen: false);
                progressNotifier.afterDelete();
              })
              .onError((e, stack) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("删除失败")));
                print(e);
              });
          },
          icon: const Icon(Icons.delete),
          iconSize: 20,
        )
      ],
    );
  }
}