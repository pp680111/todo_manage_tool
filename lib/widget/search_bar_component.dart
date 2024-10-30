import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatelessWidget {
  const SearchBarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   child: SearchAnchor(
      //     builder: (BuildContext context, SearchController controller) {
      //       return SearchBar(
      //         controller: controller,
      //         onTap: () {
      //           controller.openView();
      //         },
      //         onChanged: (_) {
      //           controller.openView();
      //         },
      //         leading: const Icon(Icons.search),
      //       );
      //     },
      //     viewElevation: false,
      //     suggestionsBuilder: (BuildContext context, SearchController controller) {
      //       return [];
      //     }
      //   ),
      // )
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          height: 60,
          child: CupertinoSearchTextField()
        )
      ),
      Icon(Icons.add)
    ]);
  }
}
