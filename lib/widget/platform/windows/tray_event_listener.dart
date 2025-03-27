import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayEventListener with TrayListener {
  DateTime lastClickTime = DateTime.now();

  @override
  void onTrayIconMouseDown() {
    DateTime now = DateTime.now();
    if (now.difference(lastClickTime) < const Duration(milliseconds: 100)) {
      windowManager.focus();
    }
    lastClickTime = now;
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

}