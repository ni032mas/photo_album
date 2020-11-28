import 'dart:io';

import 'package:aegees_photo_album/database/db.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:sqflite/sqflite.dart';

class ImageRepository {
  ImageRepository._();

  static final ImageRepository instance = ImageRepository._();

  Future<Database> _database = DBProvider.db.database;

  Future<List<ImageModel>> getAllImages() async {
    final db = await _database;
    var res = await db.query(IMAGE_TABLE);
    return res.isNotEmpty
        ? res.map((image) => ImageModel.fromMap(image)).toList()
        : Null;
  }

  Future<ImageModel> getImage(int id) async {
    final db = await _database;
    var res = await db.query(IMAGE_TABLE, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ImageModel.fromMap(res.first) : Null;
  }

  Future<int> insertImageFile(File imageFile) async {
    final db = await _database;
    return db.insert(IMAGE_TABLE, ImageModel.fileToMap(imageFile));
  }

  setSelected(int id) async {
    final db = await _database;
    var image = await getImage(id);
    return db.update(IMAGE_TABLE, image, where: "id = ?", whereArgs: [id]);
  }
}
