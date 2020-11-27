import 'dart:io';

import 'package:aegees_photo_album/models/image.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_FILE_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IMAGE ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "blob TEXT"
          ")");
    });
  }


}

const String DB_FILE_NAME = "app.db";
