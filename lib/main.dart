import 'dart:io';
import 'dart:typed_data';

import 'package:file_chooser/file_chooser.dart';
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
    if (Platform.isWindows) {
      showOpenPanel(allowedFileTypes: <FileTypeFilterGroup>[
        FileTypeFilterGroup(label: 'Images', fileExtensions: <String>[
          'bmp',
          'gif',
          'jpeg',
          'jpg',
          'png',
          'tiff',
          'webp',
        ]),
      ]).then((result) {
        if (!result.canceled) {
          try {
            String myPath = result.paths[0];
            _readFileByte(myPath).then((bytes) {
              final model = Provider.of<ImageListProvider>(context, listen: false);
              model.setBytesImage(bytes);
              //do your task here
            });
          } catch (e) {
            // if path invalid or not able to read
            print(e);
          }
        }
      });
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 10);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final model = Provider.of<ImageListProvider>(context, listen: false);
        model.setImage(_image);
      } else {
        print('No image selected.');
      }
    }
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    File file = new File(filePath);
    Uint8List bytes;
    await file.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' + onError.toString());
    });
    return bytes;
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
