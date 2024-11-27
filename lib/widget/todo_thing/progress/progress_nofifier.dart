import 'package:flutter/cupertino.dart';

class ProgressNotifier extends ChangeNotifier {
  void refreshList() {
    notifyListeners();
  }

  void afterDelete() {
    notifyListeners();
  }
}