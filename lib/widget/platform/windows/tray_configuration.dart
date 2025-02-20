import 'dart:io';

import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayConfiguration {
  static void initTray() async {
    await trayManager.setIcon('images/logo.ico');
    Menu menu = Menu(
        items: [
          MenuItem(
              key: 'show_window',
              label: '显示窗口',
              onClick: (MenuItem menuItem) async {
                await windowManager.show();
                await windowManager.focus();
              }
          ),
          MenuItem(
              key: 'exit',
              label: '退出',
              onClick: (MenuItem menuItem) async {
                await windowManager.close();
              }
          )
        ]
    );
    await trayManager.setContextMenu(menu);
    await trayManager.setToolTip("zst的工具箱");
  }

}