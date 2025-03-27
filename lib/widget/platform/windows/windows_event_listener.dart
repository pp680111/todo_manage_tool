import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsEventListener with WindowListener {
  BuildContext context;

  WindowsEventListener(this.context);

  @override
  void onWindowMinimize() async {
    windowManager.setSkipTaskbar(true);
  }


  @override
  void onWindowRestore() {
    windowManager.setSkipTaskbar(false);
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      await windowManager.focus();
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
                title: const Text('确认关闭？'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:const Text('否'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await windowManager.destroy();
                      exit(0);
                    },
                    child: const Text('是'),
                  )
                ]
            );
          }
      );
    }
  }
}