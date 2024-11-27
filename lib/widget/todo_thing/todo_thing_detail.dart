import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';
import 'package:todo_manage/utils/DateTimeUtils.dart';
import 'package:todo_manage/widget/todo_thing/progress/todo_thing_progress_list.dart';

class TodoThingDetail extends StatefulWidget {
  TodoThingDTO? item;

  TodoThingDetail({super.key, this.item});

  @override
  State<StatefulWidget> createState() {
    return _TodoThingDetailState();
  }

}

class _TodoThingDetailState extends State<TodoThingDetail> {
  Map<String, dynamic> _formData = {};
  bool insertMode = true;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _formData = widget.item!.toMap();
      insertMode = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.item == null ? const Text("编辑") : const Text("详情"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 800,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: TextEditingController(text: _formData["title"]),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "标题",
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    onChanged: (text) {
                      _formData["title"] = text;
                    },
                  )
                ),
                DropdownMenu<TodoThingState>(
                  initialSelection: _formData['status'],
                  requestFocusOnTap: true,
                  enableSearch: false,
                  label: const Text("状态"),
                  onSelected: (TodoThingState? state) {
                    _formData['status'] = state;
                  },
                  dropdownMenuEntries: TodoThingState.values
                    .map<DropdownMenuEntry<TodoThingState>>((state) {
                      return DropdownMenuEntry(
                        value: state,
                        label: state.text,
                      );
                    }).toList(),
                )
              ],
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: TextEditingController(text: _formData["detail"]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "详情",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                ),
                maxLines: 10,
                onChanged: (text) {
                  _formData["detail"] = text;
                },
              )
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (!insertMode)
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: TextEditingController(text: DateTimeUtils.formatDateTime(_formData["createTime"], DateTimeUtils.yyyyMMddHHmmFormat)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("创建时间")
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: insertMode ? 0 : 8),
                      child: TextField(
                        controller: TextEditingController(text: DateTimeUtils.formatDateTime(_formData["deadlineTime"], DateTimeUtils.yyyyMMddHHmmFormat)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("截止时间")
                        ),
                        onTap: () {_showDatePicker(context, _formData["deadlineTime"]);},
                        onChanged: (time) {
                          _formData["deadlineTime"] = time;
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
            if (!insertMode)
              TodoThingProgressList(_formData['id']),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          _doSave(context);
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context, DateTime? defaultDateTime) async {
    Future<DateTime?> selectedDate = showOmniDateTimePicker(
      context: context,
      initialDate: defaultDateTime ?? DateTime.now(),
      is24HourMode: true,
      isShowSeconds: false,
      secondsInterval: 60,
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650
      )
    );

    selectedDate.then((dateTime) {
      setState(() {
        if (dateTime != null) {
          _formData["deadlineTime"] = dateTime;
        }
      });
    });

    await selectedDate;
  }

  void _doSave(BuildContext context) {
    AppDatabase.instance.todoThingDao.insertOrUpdateFromMap(_formData)
        .then((result) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存成功"), duration: Duration(milliseconds: 500)));
          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.pop(context, true);
    }).onError((e, stackTrace) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存失败")));
          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.pop(context, false);
        });
  }
}