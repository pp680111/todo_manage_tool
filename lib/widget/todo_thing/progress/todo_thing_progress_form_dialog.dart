import 'package:flutter/material.dart';
import 'package:todo_manage/model/app_database.dart';

class TodoThingProgressFormDialog extends StatefulWidget {
  int todoThingId;

  TodoThingProgressFormDialog({super.key, required this.todoThingId});

  @override
  State<StatefulWidget> createState() {
    return _TodoThingProgressFormDialogState();
  }
}

class _TodoThingProgressFormDialogState
    extends State<TodoThingProgressFormDialog> {
  String _formContent = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("添加进度"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: 800,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "内容",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              maxLines: 5,
              onChanged: (text) {
                _formContent = text;
              },
            )
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _save(context);
          },
          child: const Text("保存")
        )
      ],
    );
  }

  void _save(BuildContext context) async {
    Map<String, dynamic> formMap = {
      'todoThingId': widget.todoThingId,
      'content': _formContent,
    };
    AppDatabase.instance.todoThingProgressDao.insert(formMap)
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存成功"), duration: Duration(milliseconds: 500)));
          Navigator.pop(context, true);
        })
        .onError((ex, stack) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存失败")));
          Navigator.pop(context, false);
        });
  }
}
