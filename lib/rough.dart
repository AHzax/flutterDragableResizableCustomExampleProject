import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resizable Image Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _imageWidth = 200.0; // Starting width of the image
  double _imageHeight = 200.0; // Starting height of the image
  double _scaleFactor = 1.0; // Scale factor to keep track of resizing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resizable Image')),
      body: Center(
        child: GestureDetector(
          // onScaleStart to capture the initial scale when gesture starts
          onScaleStart: (details) {
            _scaleFactor = 1.0; // Reset scale factor for new gesture
          },
          // onScaleUpdate to adjust width and height based on scale
          onScaleUpdate: (details) {
            setState(() {
              // Update size by accumulating scale
              _imageWidth *= details.scale / _scaleFactor;
              _imageHeight *= details.scale / _scaleFactor;
              _scaleFactor = details.scale; // Update scale factor
            });
          },
          child: Container(
            // Image container with resizable dimensions
            width: _imageWidth,
            height: _imageHeight,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/sample02.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}

  // frameHeight =
  //                                       frameHeight + imageHeight - 130.r;
  //                                   frameWidth =
  //                                       frameWidth + imageWidth - 162.r;
  //                                 });