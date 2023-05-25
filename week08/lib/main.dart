import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week08/home_screen.dart';

//final nameProvider= Provider<String>((ref) {
//  return 'Mukarram';
//});

final nameProvider= StateProvider<String?>((ref) {
  return null;
});



void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Riverpod Tutorial',
      home: MyHomePage(),
    );
  }
}

