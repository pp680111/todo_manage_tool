import 'package:tray_manager/tray_manager.dart';

class TrayConfiguration {
  static Future<void> initTray({
    required Future<void> Function() onShowMainWindow,
    required Future<void> Function() onExit,
  }) async {
    await trayManager.setIcon('images/logo.ico');
    final menu = Menu(
      items: [
        MenuItem(
          key: 'show_main_window',
          label: '显示窗口',
          onClick: (_) => onShowMainWindow(),
        ),
        MenuItem(
          key: 'exit',
          label: '关闭',
          onClick: (_) => onExit(),
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
    await trayManager.setToolTip('Todo 桌面宠物');
  }
}
