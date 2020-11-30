import 'package:aegees_photo_album/image/image_widget.dart';
import 'package:aegees_photo_album/mixin/custom_context_menu.dart';
import 'package:aegees_photo_album/models/image.dart';
import 'package:aegees_photo_album/providers/image_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> with CustomPopupMenu {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageListProvider>(builder: (context, model, child) {
      List<ImageModel> images = Provider.of<ImageListProvider>(context).images;
      if (images?.isNotEmpty == true) {
        return ListView.builder(
            cacheExtent: 500.0 * images.length,
            itemCount: images.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                child: ListTile(
                  title: ImageWidget(bytes: images[index].bytes),
                ),
                onTapDown: storePosition,
                onTap: () => _showCustomMenu(index),
                onLongPress: () => _showCustomMenu(index),
              );
            });
      } else {
        return Text("Нет данных");
      }
    });
  }

  void _showCustomMenu(int index) {
    this.showMenu(
      context: context,
      items: <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: index,
          child: Text("Удалить"),
        ),
      ],
    ).then<void>((int result) {
      if (result >= 0) {
        Provider.of<ImageListProvider>(context, listen: false).deleteImage(result);
      }
    });
  }
}
