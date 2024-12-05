//
// import 'dart:ffi';
// import 'dart:io';
//
// import 'package:drift/native.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:sqlite3/open.dart';
// import 'package:todo_manage/model/category/category_db.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   open.overrideFor(OperatingSystem.windows, _openOnWindows);
//
//   final CategoryDb db = CategoryDb.forTest(NativeDatabase.memory());
//
//   await db.into(db.category)
//       .insert(CategoryCompanion.insert(name: 'zst',
//         createTime: DateTime.now(),
//       updateTime: DateTime.now()));
//   List<CategoryData> list = await db.select(db.category).get();
//   print('$list');
//
// }
//
// DynamicLibrary _openOnWindows() {
//   final script = File(Platform.script.toFilePath()).parent;
//   final libraryNextToScript = File('${script.path}\\sqlite3.dll');
//   return DynamicLibrary.open(libraryNextToScript.path);
// }
