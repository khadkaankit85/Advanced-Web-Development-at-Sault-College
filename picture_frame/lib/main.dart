import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(DigitalPictureFrame());
}

class DigitalPictureFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PictureFrameScreen(),
    );
  }
}

class PictureFrameScreen extends StatefulWidget {
  @override
  _PictureFrameScreenState createState() => _PictureFrameScreenState();
}

class _PictureFrameScreenState extends State<PictureFrameScreen> {
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg',
    'https://images.pexels.com/photos/34950/pexels-photo.jpg',
    'https://images.pexels.com/photos/36717/amazing-animal-beautiful-beautifull.jpg',
    'https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg',
    'https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg',
    'https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg',
    'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
    'https://images.pexels.com/photos/158607/cairn-fog-mystical-background-158607.jpeg',
    'https://images.pexels.com/photos/1054289/pexels-photo-1054289.jpeg',
    'https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg',
  ];

  int currentIndex = 0;
  Timer? timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startImageRotation();
  }

  void startImageRotation() {
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      if (!isPaused) {
        setState(() {
          currentIndex = (currentIndex + 1) % imageUrls.length;
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Digital Picture Frame'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 10), // Custom frame
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: Image.network(
            imageUrls[currentIndex],
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: togglePause,
        child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}
