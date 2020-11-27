import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Uint8List bytes;

  ImageWidget({Key key, this.bytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          child: Image.memory(bytes),
        ),
      ),
    );
  }
}
