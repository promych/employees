import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _openDatabase();
    return _db;
  }

  Future<Database> _openDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'ekf.db');
    Database database = await databaseFactoryIo.openDatabase(path);
    return database;
  }
}
