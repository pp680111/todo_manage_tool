import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatelessWidget {
  const SearchBarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          height: 50,
          child: CupertinoSearchTextField()
        )
      ),
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: IconButton(
          icon: const Icon(Icons.add, size: 40,),
          onPressed: () {

          },
        )
      )
    ]);
  }
}
