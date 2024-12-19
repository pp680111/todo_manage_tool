import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  Function onSearchChange;
  Function onAddButtonPress;
  bool enableCustomFilter;
  void Function(BuildContext ctx)? onCustomFilterPress;

  SearchBarComponent({super.key,
    required this.onSearchChange,
    required this.onAddButtonPress,
    this.enableCustomFilter = false,
    this.onCustomFilterPress});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarComponentState();
  }
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  bool _filterToggle = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.only(top: 8),
                height: 50,
                child: CupertinoSearchTextField(
                  placeholder: "请输入关键词",
                  onChanged: (text) {
                    widget.onSearchChange(text);
                  },
                )
            )
        ),
        if (widget.enableCustomFilter)
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
              icon: Icon(_filterToggle ? Icons.filter_alt_sharp : Icons.filter_alt_off_sharp, size: 34,),
              onPressed: () {
                setState(() {
                  _filterToggle = !_filterToggle;
                });
                widget.onCustomFilterPress?.call(context);
              },
            )
          ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
              icon: const Icon(Icons.add, size: 40,),
              onPressed: () {
                widget.onAddButtonPress(context);
              },
            )
        )
      ]
    );
  }
}
