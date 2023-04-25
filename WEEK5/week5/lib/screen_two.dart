import 'package:flutter/material.dart';
import 'package:week5/screen_three.dart';

class ScreenTwo extends StatefulWidget {
  static const String id = 'screen_two';
  // final String name;
  // final int num;
  const ScreenTwo({Key? key,
  // required this.name,
  // this.num=2
  }) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    final argument=ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(

          title: Text(argument['name']+' '+argument['age'].toString()),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenThree(
                      name: 'Tasmia',
                      num: 2,
                    ))
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.green
                ),
                child: const Center(
                  child: Text('Screen 2'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
