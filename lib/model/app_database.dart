import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_manage/model/todo_thing/todo_thing.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dao.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress.dart';
import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_dao.dart';

import 'category/category_dao.dart';
import 'category/category.dart' as my_category;

part 'app_database.g.dart';

@DriftDatabase(tables: [TodoThing, TodoThingProgress, my_category.Category], daos: [TodoThingDao, TodoThingProgressDao, CategoryDao])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();

      String path = "";
      if (kDebugMode) {
        path = '${dbFolder.path}/zst_todo_tools/debug/app_database.sqlite';
      } else if (kReleaseMode) {
        path = '${dbFolder.path}/zst_todo_tools/release/app_database.sqlite';
      } else {
        throw Exception("Unknown build mode");
      }

      File dbFile = File(path);

      return NativeDatabase(dbFile, logStatements: true);
    });
  }
}