import 'dart:io';

import 'package:aegees_photo_album/database/local_database.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:hive/hive.dart';

class ImageRepository {
  ImageRepository._();

  static final ImageRepository _singleton = ImageRepository._();

  factory ImageRepository() {
    return _singleton;
  }

  Box<ImageModel> _boxImage = LocalDataBase.boxImage;

  Future<List<ImageModel>> getAllImages() async {
    return _boxImage.values?.toList();
  }

  Future<ImageModel> getImage(int id) async {
    return _boxImage.get(id);
  }

  Future<ImageModel> insertAndGetImageFile(File imageFile) async {
    var id = _boxImage.length - 1;
    if (id < 0) id = 0;
    var image = ImageModel(id: id, bytes: imageFile.readAsBytesSync());
    _boxImage.add(image);
    return image;
  }

  Future<int> insertImage(ImageModel image) async => _boxImage.add(image);

  setSelected(int id) async {
    var image = _boxImage.getAt(id);
    image.isSelected = true;
    image.save();
  }
}
