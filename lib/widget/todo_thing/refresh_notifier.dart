import 'package:flutter/widgets.dart';

class RefreshNotifier extends ChangeNotifier {
  void doRefresh() {
    notifyListeners();
  }
}