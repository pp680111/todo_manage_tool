import 'package:flutter/cupertino.dart';

class ProgressNotifier extends ChangeNotifier {
  void afterDelete() {
    notifyListeners();
  }
}