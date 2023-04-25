import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       backgroundColor: Color.fromRGBO(0, 128, 128,1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(10, 172, 110, 1),
          title: Text('Mukarram App'),

        ),
        body: const Center(
          child: Image(
              image: AssetImage('assets/mukarram.jpg'),

          ),

        ),

      ),
    );
  }
}