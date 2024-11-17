import 'package:flutter/widgets.dart';

class TodoThingItemProvider extends ChangeNotifier {
  TodoThingItemProvider () {
  }

  void refresh() {
    notifyListeners();
  }

  void deleteItem() {
    notifyListeners();
  }
}