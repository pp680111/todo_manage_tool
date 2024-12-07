import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/category/category_dto.dart';

import '../../utils/DateTimeUtils.dart';

class CategoryDetail extends StatefulWidget {
  CategoryDTO? item;

  CategoryDetail({super.key, this.item});

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailState();
  }
}

class _CategoryDetailState extends State<CategoryDetail> {
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
        title: widget.item == null ? const Text("新增") : const Text("详情"),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: TextEditingController(text: _formData["name"]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "名称",
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
                  _formData["name"] = text;
                },
              )
            ),
            if (!insertMode)
              Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextField(
                          controller: TextEditingController(text: DateTimeUtils.formatDateTime(_formData["createTime"], DateTimeUtils.yyyyMMddHHmmFormat)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("创建时间")
                          )
                        )
                      )
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: TextEditingController(text: DateTimeUtils.formatDateTime(_formData["updateTime"], DateTimeUtils.yyyyMMddHHmmFormat)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("更新时间")
                          ),
                          onTap: () {_showDatePicker(context, _formData["updateTime"]);},
                        )
                      )
                    )
                  ]
                )
              )
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
    AppDatabase.instance.categoryDao.insertOrUpdateFromMap(_formData)
        .then((_) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存成功"), duration: Duration(seconds: 500)));
          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.pop(context, true);
        }).onError((e, stack) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("保存失败"), duration: Duration(seconds: 500)));
          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.pop(context, false);
        });
  }
}