import 'package:tray_manager/tray_manager.dart';

class TrayEventListener with TrayListener {
  TrayEventListener({required this.onActivate});

  final Future<void> Function() onActivate;

  @override
  void onTrayIconMouseDown() {
    onActivate();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }
}
