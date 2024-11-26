import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/widget/todo_thing/progress/progress_nofifier.dart';
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProgressNotifier(),
      child: Column(
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
          Consumer<ProgressNotifier>(
            builder: (context, provider, child) {
              return Container(
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
                      if (!snapshot.hasData || snapshot.requireData.isEmpty) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("暂未添加进度", style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        );
                      }

                      List<TodoThingProgressDTO> progressList = snapshot.requireData;
                      return Column(
                        children: progressList.map((dto) {
                          return ProgressItem(dto);
                        }).toList()
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      )
    );
  }
}

