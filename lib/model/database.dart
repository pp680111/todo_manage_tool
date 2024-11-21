import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DatabaseConstant {
  static File? _dbFile;

  static Future<File> getSqliteFile() async {
    if (_dbFile != null) return _dbFile!;

    final dbFolder = await getApplicationDocumentsDirectory();
    _dbFile = File('${dbFolder.path}/db.sqlite');

    return _dbFile!;
  }
}