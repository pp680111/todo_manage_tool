import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:todo_manage/model/app_database.dart';
import 'package:todo_manage/model/category/category_dto.dart';

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
            // DropDownSearchField(
            //   textFieldConfiguration: TextFieldConfiguration(
            //     controller: TextEditingController(
            //         text: _selectedCategoryName ?? ""
            //     ),
            //     decoration: const InputDecoration(
            //       // border: OutlineInputBorder(),
            //       label: Text(
            //         "所属类型",
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     )
            //   ),
            //   suggestionsCallback: (pattern) async {
            //     return AppDatabase.instance.categoryDao.page(1, 50, pattern);
            //   },
            //   itemBuilder: (context, category) {
            //     return ListTile(
            //       title: Text(category.name),
            //     );
            //   },
            //   onSuggestionSelected: (category) {
            //     widget.filter['categoryId'] = category.id;
            //     _selectedCategoryName = category.name;
            //     setState(() {});
            //   },
            //   noItemsFoundBuilder: (context) {
            //     return Container(
            //       padding: const EdgeInsets.all(8.0),
            //       child: const Text("无匹配项"),
            //     );
            //   },
            //   isMultiSelectDropdown: false,
            //   displayAllSuggestionWhenTap: false,
            // )
            SearchableDropdown<CategoryDTO>.paginated(
              hintText: const Text("所属类型"),
              isDialogExpanded: false,
              dialogOffset: 0,
              requestItemCount: 50,
              paginatedRequest: (int pageIndex, String? searchKey) async {
                return AppDatabase.instance.categoryDao.page(pageIndex, 50, searchKey)
                    .then((list) {
                      return list.map((i) =>
                          SearchableDropdownMenuItem(value: i, label: i.name, child: Text(i.name))).toList();
                    });
              },
              onChanged: (CategoryDTO? selectedItem) {
                if (selectedItem != null) {
                  widget.filter['categoryId'] = selectedItem.id;
                } else {
                  widget.filter.remove('categoryId');
                }
              },
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