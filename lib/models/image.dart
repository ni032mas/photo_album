import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'image.g.dart';

@HiveType(typeId: 0)
class ImageModel extends HiveObject {
  ImageModel({this.id, this.bytes, this.isSelected = false});

  @HiveField(0)
  int id;
  @HiveField(1)
  Uint8List bytes;
  @HiveField(2)
  bool isSelected;
}

const IMAGE_TABLE = "IMAGE";
const ID_COLUMN = "id";
const BLOB_COLUMN = "blob";
const IS_SELECTED_COLUMN = "is_selected";
