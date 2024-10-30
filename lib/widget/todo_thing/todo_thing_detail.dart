import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/utils/DateTimeUtils.dart';

class TodoThingDetail extends StatefulWidget {
  TodoThingDTO item;

  TodoThingDetail({super.key, required this.item});

  @override
  State<StatefulWidget> createState() {
    return _TodoThingDetailState();
  }

}

class _TodoThingDetailState extends State<TodoThingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情"),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: TextEditingController(text: widget.item.title),
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
            )
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: TextEditingController(text: widget.item.detail),
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
            )
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: TextField(
                      controller: TextEditingController(text: DateTimeUtils.formatDateTime(widget.item.createTime, DateTimeUtils.yyyyMMddHHmmFormat)),
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
                    padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8, left: 8),
                    child: TextField(
                      controller: TextEditingController(text: DateTimeUtils.formatDateTime(widget.item.deadlineTime, DateTimeUtils.yyyyMMddHHmmFormat)),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("截止时间")
                      ),
                      onTap: () {_showDatePicker(context, widget.item.deadlineTime);},
                    ),
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildProgressItem(index);
              },
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            )
          )
        ],
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
          widget.item.deadlineTime = dateTime;
        }
      });
    });

    await selectedDate;
  }

  Widget _buildProgressItem(int index) {
    return Placeholder();
  }
}