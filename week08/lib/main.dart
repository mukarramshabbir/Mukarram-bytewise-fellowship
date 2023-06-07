import 'package:flutter/material.dart';
import 'package:week08/realtime_edge_detection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edge Scanner App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RealtimeEdgeDetectionScreen(),
    );
  }
}
