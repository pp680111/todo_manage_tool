import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_db.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/utils/DateTimeUtils.dart';
import 'package:todo_manage/widget/progressing_overlay.dart';

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
  bool editMode = true;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _formData = widget.item!.toMap();
      editMode = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.item == null ? const Text("编辑") : const Text("详情"),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
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
                if (!editMode)
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
                    padding: EdgeInsets.only(left: editMode ? 0 : 8),
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
          if (!editMode)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _buildProgressItem(index);
                },
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
              )
            ),
        ],
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

  Widget _buildProgressItem(int index) {
    return Placeholder();
  }

  void _doSave(BuildContext context) {
    ProgressingOverlay.show(context, "保存中");

    TodoThingDb.instance.insertOrUpdateFromMap(_formData)
        .then((result) {
          ProgressingOverlay.success(context, "保存成功")
              .then((_) {
                 Navigator.pop(context);
              });
        });
  }
}