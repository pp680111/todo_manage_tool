import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_db.dart';

import '../../model/todo_thing_progress/todo_thing_progress_dto.dart';

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
    TodoThingProgressDb.instance.getProgress(widget.todoThingId)
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
              Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // TODO 弹出编辑框
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
              // future: TodoThingProgressDb.instance.getProgress(widget.todoThingId),
              future: _mockData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                List<TodoThingProgressDTO> progressList = snapshot.requireData;
                return Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: progressList.map((dto) {
                      return _ProgressItem(dto);
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

  Future<List<TodoThingProgressDTO>> _mockData() {
    List<TodoThingProgressDTO> mockData = [];
    for (int i = 0; i < 20; i++) {
      mockData.add(TodoThingProgressDTO(i, 1, "progress $i", false, DateTime.now(), DateTime.now()));
    }
    return Future.value(mockData);
  }
}

class _ProgressItem extends StatelessWidget {
  TodoThingProgressDTO progress;

  _ProgressItem(this.progress);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        progress.content,
        style: TextStyle(
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

          },
          icon: const Icon(Icons.delete),
          iconSize: 20,
        )
      ],
    );
  }
}