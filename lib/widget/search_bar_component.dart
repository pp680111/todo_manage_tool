import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  Function onSearchChange;
  Function onAddButtonPress;
  bool displayBackwardButton;
  void Function(BuildContext ctx)? onBackwardButtonPress;

  SearchBarComponent({super.key,
    required this.onSearchChange,
    required this.onAddButtonPress,
    this.displayBackwardButton = false,
    this.onBackwardButtonPress});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarComponentState();
  }
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.displayBackwardButton)
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, size: 36),
              onPressed: () {
                if (widget.onBackwardButtonPress != null) {
                  widget.onBackwardButtonPress!(context);
                }
              },
            ),
          ),
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
