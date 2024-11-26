import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  Function onSearchChange;
  Function onAddButtonPress;

  SearchBarComponent({super.key, required this.onSearchChange, required this.onAddButtonPress});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarComponentState();
  }
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 8),
              height: 50,
              child: CupertinoSearchTextField(
                onChanged: (text) {
                  widget.onSearchChange(text);
                },
              )
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
    ]);
  }
}
