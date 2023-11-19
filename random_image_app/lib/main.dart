import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Image App',
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
    try {
      // Get the list of assets in the 'assets/images' directory
      final manifestContent =
          await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = json.decode(manifestContent);
      final imagePaths = manifest.keys
          .where((String key) => key.contains('images/'))
          .toList();

      setState(() {
        _imagePaths = imagePaths;
        _imagePaths.shuffle();
        _imageIndex = 0;
      });
    } catch (e) {
      print('Error loading image paths: $e');
    }
  }

  void _loadNextImage() {
    setState(() {
      _imageIndex = (_imageIndex + 1) % _imagePaths.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Image App'),
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
