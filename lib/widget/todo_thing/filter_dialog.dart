import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_manage/model/app_database.dart';

class FilterDialog extends StatefulWidget {
  Map<String, dynamic> filter;

  FilterDialog({super.key, required this.filter});

  @override
  State<StatefulWidget> createState() {
    return _FilterDialogState();
  }
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedCategoryName;

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
                    text: _selectedCategoryName ?? ""
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
                _selectedCategoryName = category.name;
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