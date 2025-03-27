import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:todo_manage/widget/main_page.dart';
import 'package:todo_manage/widget/platform/windows/tray_configuration.dart';
import 'package:todo_manage/widget/platform/windows/windows_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (await FlutterSingleInstance().isFirstInstance()) {
    WindowsConfiguration.initWindow();
    TrayConfiguration.initTray();
    runApp(const MyApp());
  } else {
    final err = await FlutterSingleInstance().focus();
    exit(0);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,

      ),
      home: const MainPage()
    );
  }
}