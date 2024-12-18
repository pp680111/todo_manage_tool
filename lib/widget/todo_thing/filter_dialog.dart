import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

class FilterDialog extends StatefulWidget {
  Map<String, dynamic> filter;
  Map<String, dynamic> stateStorage = {};

  FilterDialog({super.key, required this.filter});

  @override
  State<StatefulWidget> createState() {
    return _FilterDialogState();
  }
}

class _FilterDialogState extends State<FilterDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("过滤条件"),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropDownSearchField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: TextEditingController(
                    text: widget.stateStorage['category']?.name ?? ""
                ),
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  label: Text(
                    "所属类型",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ),
              suggestionsCallback: (pattern) async {
                return AppDatabase.instance.categoryDao.page(1, 50, pattern);
              },
              itemBuilder: (context, category) {
                return ListTile(
                  title: Text(category.name),
                );
              },
              onSuggestionSelected: (category) {
                widget.filter['categoryId'] = category.id;
                widget.stateStorage['category'] = category;
                setState(() {});
              },
              noItemsFoundBuilder: (context) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("无匹配项"),
                );
              },
              isMultiSelectDropdown: false,
              displayAllSuggestionWhenTap: false,
              initiallySelectedItems: widget.stateStorage['category'] != null ? [widget.stateStorage['category']!] : [],
            ),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: DropdownMenu<TodoThingState>(
                expandedInsets: const EdgeInsets.only(top: 8.0),
                label: const Text("状态", style: TextStyle(color: Colors.grey)),
                inputDecorationTheme: const InputDecorationTheme(
                ),
                trailingIcon: const Icon(null, blendMode: BlendMode.clear),
                selectedTrailingIcon: const Icon(null),
                dropdownMenuEntries: TodoThingState.values.map((s) {
                  return DropdownMenuEntry(value: s, label: s.text);
                }).toList(),
                onSelected: (state) {
                  widget.filter['status'] = state?.index;
                  widget.stateStorage['state'] = state;
                },
                initialSelection: widget.stateStorage['state'],
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.filter.clear();
            Navigator.pop(context);
          },
          child: const Text("重置条件")
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("确认")
        )
      ],
    );
  }
}