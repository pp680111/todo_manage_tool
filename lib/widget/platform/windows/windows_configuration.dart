import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

class WindowsConfiguration {
  static void initWindow() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions opt = WindowOptions(
        title: 'TODO',
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal
    );

    windowManager.waitUntilReadyToShow(
        opt, () async {
      await windowManager.show();
      await windowManager.focus();
      }
    );

    await windowManager.setPreventClose(true);
  }
}