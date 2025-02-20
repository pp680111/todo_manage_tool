import 'package:tray_manager/tray_manager.dart';

class TrayEventListener with TrayListener {
  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }
}