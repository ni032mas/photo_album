import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

class ImageModel {
  ImageModel({this.id, this.blob, this.bytes, this.isSelected});

  int id;
  String blob;
  Uint8List bytes;
  bool isSelected;

  static const Base64Codec base64 = Base64Codec();

  static ImageModel fromMap(Map map) {
    ImageModel image = ImageModel();
    image.id = map[ID_COLUMN];
    image.blob = map[BLOB_COLUMN];
    image.bytes = base64.decode(image.blob);
    return image;
  }

  static Map<String, dynamic> fileToMap(File image) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map[BLOB_COLUMN] = base64.encode(image.readAsBytesSync());
    return map;
  }
}

const IMAGE_TABLE = "IMAGE";
const ID_COLUMN = "id";
const BLOB_COLUMN = "blob";
