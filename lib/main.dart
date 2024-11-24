import 'package:flutter/material.dart';
import 'package:todo_manage/model/database.dart';
import 'package:todo_manage/widget/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConstant.init();
  runApp(const MyApp());
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