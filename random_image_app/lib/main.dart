import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:path/path.dart';


Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Use the env variable to set the app title or use a default
      title: dotenv.get('APP_TITLE', fallback: 'Random Image App'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _imageIndex = 0;
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImagePaths();
  }

  void _loadImagePaths() async {
    List<String> imagePaths = [];

    // Specify the path to the directory containing images
    Directory directory = Directory('/images');

    // List all files in the directory
    List<FileSystemEntity> files = directory.listSync();

    // Filter out only image files (you can customize the list of supported extensions)
    List<String> supportedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    for (var file in files) {
      if (file is File && supportedExtensions.contains(file.path.toLowerCase().split('.').last)) {
        imagePaths.add(file.path);
      }
    }

    setState(() {
      _imagePaths = imagePaths;
      _imagePaths.shuffle();
      _imageIndex = 0;
    });
  }

  void _loadNextImage() {
    // Refresh the image list
    _loadImagePaths();
    // Load the next image
    setState(() {
      _imageIndex = (_imageIndex + 1) % _imagePaths.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text(dotenv.get('APP_TITLE', fallback: 'Random Image App')),
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.space) {
              _loadNextImage();
            }
          }
        },
        child: Column(      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  _imagePaths[_imageIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _loadNextImage,
                child: Text('Load Next Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
