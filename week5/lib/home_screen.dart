import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:week5/screen_two.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Mukarram App')

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, ScreenTwo.id
                ,arguments: {
                  'name':'Asif Taj',
                      'age':21
                    });
                // Navigator.push(context,
                // MaterialPageRoute(builder: (context) => ScreenTwo(
                // name: 'Mukarram Ali',
                // num: 12,
                // ))
                // );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.green
                ),
                child: const Center(
                  child: Text('Screen 1'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

