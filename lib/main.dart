import 'dart:io';

import 'package:aegees_photo_album/database/local_database.dart';
import 'package:aegees_photo_album/widgets/image_list_screen.dart';
import 'package:aegees_photo_album/providers/image_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalDataBase.initDB();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ImageListProvider>(
          create: (context) => ImageListProvider())
    ],
    child: AegeesApp(),
  ));
}

class AegeesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 10);
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
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
