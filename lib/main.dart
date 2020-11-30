import 'dart:io';

import 'package:photo_album/database/local_database.dart';
import 'package:photo_album/widgets/fab.dart';
import 'package:photo_album/widgets/image_list_screen.dart';
import 'package:photo_album/providers/image_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalDataBase.initDB();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<ImageListProvider>(create: (context) => ImageListProvider())],
    child: PhotoAlbumApp(),
  ));
}

class PhotoAlbumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo album',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Photo album'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final model = Provider.of<ImageListProvider>(context, listen: false);
      model.setImage(_image);
    } else {
      print('No image selected.');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 10);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final model = Provider.of<ImageListProvider>(context, listen: false);
      model.setImage(_image);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ImageListScreen(),
      ),
      floatingActionButton: CustomFab(
        onPressedImage: getImage,
        onPressedCamera: getCamera,
        tooltip: 'Pick Image',
      ),
    );
  }
}
