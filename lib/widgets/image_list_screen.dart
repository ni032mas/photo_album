import 'package:aegees_photo_album/image/image_widget.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:aegees_photo_album/providers/image_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageListProvider>(builder: (context, model, child) {
      List<ImageModel> images = Provider.of<ImageListProvider>(context).images;
      if (images?.isNotEmpty == true) {
        return ListView.builder(
            cacheExtent: 500.0 * images.length,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ImageWidget(bytes: images[index].bytes),
              );
            });
      } else {
        return Text("Нет данных");
      }
    });
  }
}
