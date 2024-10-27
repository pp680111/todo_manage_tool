import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';

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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: TextEditingController(text: "ss"),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("创建时间")
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
  );
  }
}