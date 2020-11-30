import 'package:photo_album/models/image.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataBase {
  static Box<ImageModel> boxImage;

  static initDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ImageModelAdapter());
    boxImage = await Hive.openBox<ImageModel>(IMAGE_TABLE);
  }
}
