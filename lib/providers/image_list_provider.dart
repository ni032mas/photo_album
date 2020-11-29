import 'dart:io';

import 'package:aegees_photo_album/models/image.dart';
import 'package:aegees_photo_album/repositories/image_repository.dart';
import 'package:flutter/material.dart';

class ImageListProvider with ChangeNotifier {
  var _imageRepository = ImageRepository();
  var _images = List<ImageModel>();

  get images => _images;

  ImageListProvider() {
    init();
  }

  init() async {
    _images = await _imageRepository.getAllImages();
    notifyListeners();
  }

  setImage(File imageFile) async {
    var image = await _imageRepository.insertAndGetImageFile(imageFile);
    _images.add(image);
    notifyListeners();
  }

  setSelected(int id) async {
    await _imageRepository.setSelected(id);
  }
}
