import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsConfiguration {
  static const Size petSize = Size(110, 120);
  static const Size mainWindowSize = Size(1000, 720);
  static const Size mainWindowMinimumSize = Size(640, 480);

  static Offset? _petPosition;

  static Future<void> initPetWindow() async {
    await windowManager.ensureInitialized();

    const options = WindowOptions(
      title: 'Todo 桌面宠物',
      size: petSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );

    await windowManager.waitUntilReadyToShow(options, () async {
      await _applyPetWindowStyle();
      await windowManager.show();
      await windowManager.setAlignment(Alignment.bottomRight);
      _petPosition = await windowManager.getPosition();
    });
    await windowManager.setPreventClose(true);
  }

  static Future<void> showPetWindow() async {
    // Windows ignores SetWindowPos bounds while a window is minimized and
    // SW_RESTORE would clobber them again, so normalize the window state and
    // hide it before applying the pet size; otherwise the pet reappears at
    // the old main-window size.
    if (await windowManager.isMinimized() ||
        await windowManager.isMaximized()) {
      await windowManager.restore();
      await windowManager.hide();
    }
    await windowManager.setTitle('Todo 桌面宠物');
    await _applyPetWindowStyle();
    if (_petPosition != null) {
      await windowManager.setPosition(_petPosition!);
    } else {
      await windowManager.setAlignment(Alignment.bottomRight);
      _petPosition = await windowManager.getPosition();
    }
    await windowManager.show(inactive: true);
    await windowManager.setPreventClose(true);
  }

  static Future<void> rememberPetPosition() async {
    _petPosition = await windowManager.getPosition();
  }

  static Future<void> showMainWindow() async {
    await rememberPetPosition();
    await windowManager.setTitle('TODO');
    await windowManager.setAlwaysOnTop(false);
    await windowManager.setSkipTaskbar(false);
    await windowManager.setResizable(true);
    await windowManager.setMinimumSize(mainWindowMinimumSize);
    await windowManager.setMaximizable(true);
    await windowManager.setMinimizable(true);
    await windowManager.setHasShadow(true);
    await windowManager.setBackgroundColor(Colors.white);
    // The main window draws its own caption bar in MainPage; keeping the
    // native title bar hidden avoids Windows not repainting the caption
    // buttons after switching back from the frameless pet mode.
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setSize(mainWindowSize);
    await windowManager.center();
    await windowManager.restore();
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setPreventClose(true);
  }

  static Future<void> _applyPetWindowStyle() async {
    await windowManager.setAsFrameless();
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setAlwaysOnTop(true);
    await windowManager.setSkipTaskbar(true);
    await windowManager.setResizable(false);
    await windowManager.setMinimumSize(petSize);
    await windowManager.setMaximizable(false);
    await windowManager.setMinimizable(false);
    await windowManager.setHasShadow(false);
    await windowManager.setSize(petSize);
  }
}
