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
    // TrackPopupMenu only tracks correctly when the owning window is
    // foreground; otherwise the menu flashes and closes instantly while
    // Explorer keeps focus. This app is Windows-only, so the deprecated
    // parameter is exactly the supported fix (MSDN KB135788).
    // ignore: deprecated_member_use
    trayManager.popUpContextMenu(bringAppToFront: true);
  }
}
