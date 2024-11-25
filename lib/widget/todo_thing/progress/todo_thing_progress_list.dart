import 'package:flutter/material.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/todo_thing/progress/todo_thing_progress_form_dialog.dart';
import 'package:todo_manage/widget/todo_thing/progress/todo_thing_progress_list_item.dart';

import '../../../model/todo_thing_progress/todo_thing_progress_dto.dart';

class TodoThingProgressList extends StatefulWidget {
  int todoThingId;

  TodoThingProgressList(this.todoThingId, {super.key});

  @override
  State<TodoThingProgressList> createState() => _TodoThingProgressListState();
}

class _TodoThingProgressListState extends State<TodoThingProgressList> {
  List<TodoThingProgressDTO> progressList = [];


  @override
  void initState() {
    AppDatabase.instance.todoThingProgressDao.getProgress(widget.todoThingId)
        .then((result) {
          progressList = result;
          setState(() {});
        }).onError((e, stackTrace) {

        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Row (
            children: [
              const Text(
                "进度",
                style: TextStyle (
                  fontSize: 16
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(context: context, builder: (context) => TodoThingProgressFormDialog(todoThingId : widget.todoThingId))
                  .then((_) {
                    setState(() {});
                  });
                },
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              )
            ),
            child: FutureBuilder<List<TodoThingProgressDTO>>(
              future: AppDatabase.instance.todoThingProgressDao.getProgress(widget.todoThingId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                List<TodoThingProgressDTO> progressList = snapshot.requireData;
                return Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: progressList.map((dto) {
                      return ProgressItem(dto);
                    }).toList()
                  )
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

