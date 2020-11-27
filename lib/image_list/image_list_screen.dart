import 'dart:io';

import 'package:aegees_photo_album/image/image_widget.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:aegees_photo_album/repositories/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageListProvider with ChangeNotifier {
  var _imageRepository = ImageRepository.instance;

  setImage(File image) async {
    _imageRepository.insertImage(image);
    notifyListeners();
  }

  Future<List<ImageModel>> getImages() async {
    return _imageRepository.getImages();
  }
}

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageListProvider>(builder: (context, model, child) {
      return FutureBuilder<List<ImageModel>>(
          future: Provider.of<ImageListProvider>(context).getImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                var error = snapshot.error;
                return Text('$error');
              }
              List<ImageModel> images = snapshot.data;
              if (images?.isNotEmpty == true) {
                return ListView.builder(
                    cacheExtent: 500.0 * images.length,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: ImageWidget(bytes: images[index].bytes),);
                    });
              } else {
                return Text("Нет данных");
              }
            } else {
              return CircularProgressIndicator();
            }
          });
    });
  }
}
