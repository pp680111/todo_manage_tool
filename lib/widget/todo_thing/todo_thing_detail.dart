import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';
import 'package:todo_manage/utils/DateTimeUtils.dart';
import 'package:todo_manage/widget/todo_thing/progress/todo_thing_progress_list.dart';

import '../../model/category/category_dto.dart';
import '../category/category_select_dialog.dart';

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

  // 获取所有分类
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
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          fontSize: 16
                      ),
                      onChanged: (text) {
                        _formData["title"] = text;
                      },
                    )
                  ),
                ),
                if (!insertMode)
                  Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: DropdownMenu<TodoThingState>(
                      label: const Text("状态"),
                      initialSelection: _formData['status'],
                      dropdownMenuEntries: TodoThingState.values.map<DropdownMenuEntry<TodoThingState>>((state) {
                        return DropdownMenuEntry<TodoThingState>(
                          value: state,
                          label: state.text,
                        );
                      }).toList(),
                      onSelected: (state) {
                        _formData['status'] = state;
                      },
                    )
                  )
              ],
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                controller: TextEditingController(text: _formData["categoryName"]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "所属类别",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                    maxLines: 1,
                  ),
                ),
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return const CategorySelectDialog();
                  }).then((category) {
                    if (category != null) {
                      setState(() {
                        _formData["categoryId"] = category.id;
                        _formData["categoryName"] = category.name;
                      });
                    }
                  });
                },
              ),
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