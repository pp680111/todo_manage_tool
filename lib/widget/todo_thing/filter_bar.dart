import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/app_database.dart';
import '../../model/todo_thing/todo_thing_state.dart';

class FilterBar extends StatefulWidget {
  void Function(Map<String, dynamic>) onFilterChange;

  FilterBar({super.key, required this.onFilterChange});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final Map<String, dynamic> _listParams = {};
  final Map<String, dynamic> _widgetStateStorage = {};
  final TextEditingController _statusFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownMenu<TodoThingState>(
            controller: _statusFieldController,
            enableSearch: false,
            label: const Text(
                "状态",
                style: TextStyle(color: Colors.grey)
            ),
            inputDecorationTheme: const InputDecorationTheme(
            ),
            textStyle: const TextStyle(
                fontSize: 14
            ),
            dropdownMenuEntries: TodoThingState.values.map((s) {
              return DropdownMenuEntry(
                  value: s,
                  label: s.text,
                  style: const ButtonStyle(
                      textStyle: WidgetStatePropertyAll(
                          TextStyle(
                              fontSize: 14
                          )
                      )
                  )
              );
            }).toList(),
            onSelected: (state) {
              _listParams['status'] = state?.index;
              _widgetStateStorage['state'] = state;
              _onFilterChange();
            },
          ),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropDownSearchField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: TextEditingController(
                    text: _widgetStateStorage['category']?.name ?? ""
                ),
                decoration: InputDecoration(
                    label: const Text(
                      "所属类型",
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(icon: const Icon(Icons.arrow_drop_down), onPressed: () {})
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
              _listParams['categoryId'] = category.id;
              _widgetStateStorage['category'] = category;
              setState(() {
              });
              _onFilterChange();
            },
            noItemsFoundBuilder: (context) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text("无匹配项"),
              );
            },
            isMultiSelectDropdown: false,
            displayAllSuggestionWhenTap: true,
          )
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              _listParams.clear();
              _widgetStateStorage.clear();

              _statusFieldController.clear();

              _onFilterChange();
            });
          },
          child: const Text("重置")
        )
      ],
    );
  }

  void _onFilterChange() {
    widget.onFilterChange(_listParams);
  }
}