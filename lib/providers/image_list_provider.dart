import 'dart:io';

import 'package:aegees_photo_album/models/image.dart';
import 'package:aegees_photo_album/repositories/image_repository.dart';
import 'package:flutter/material.dart';

class ImageListProvider with ChangeNotifier {
  var _imageRepository = ImageRepository.instance;
  var _images = List<ImageModel>();

  ImageListProvider() {
    init();
  }

  init() async {
    _images = await _imageRepository.getAllImages();
    notifyListeners();
  }

  setImage(File imageFile) async {
    var id = await _imageRepository.insertImageFile(imageFile);
    var image = await _imageRepository.getImage(id);
    if (image != null) {
      _images.add(image);
      notifyListeners();
    }
  }

  Future<List<ImageModel>> getImages() async {
    if (_images.isEmpty) _images = await _imageRepository.getAllImages();
    return _images;
  }

  setSelected(int id) async {
    await _imageRepository.setSelected(id);
  }
}
