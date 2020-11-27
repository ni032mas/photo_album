import 'dart:io';

import 'package:aegees_photo_album/database/db.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:sqflite/sqflite.dart';

class ImageRepository {
  ImageRepository._();

  static final ImageRepository instance = ImageRepository._();

  Future<Database> _database = DBProvider.db.database;

  Future<List<ImageModel>> getImages() async {
    final db = await _database;
    var res = await db.query(IMAGE);
    return res.isNotEmpty
        ? res.map((image) => ImageModel.fromMap(image)).toList()
        : Null;
  }

  void insertImage(File image) async {
    final db = await _database;
    await db.insert(IMAGE, ImageModel.toMap(image));
  }
}
