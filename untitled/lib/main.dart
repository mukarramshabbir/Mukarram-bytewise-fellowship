import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var arrname=['muka','ali','rana','muhammad','adas'];
    return Scaffold(
      appBar: AppBar(
        title: Text('My APP'),
      ),
      body: ListView.separated(itemBuilder: (context,index) {
        return Row(
          children: [
            Column(
              children: [
                Text(arrname[index], style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                Text(arrname[index], style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
              ],
            ),
            Text(arrname[index], style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
            Text(arrname[index], style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
          ]

        );
      },
        itemCount: arrname.length,
        separatorBuilder: (context,index){
        return Divider(
          height: 50,
          thickness: 3,
        );
        },
      )

    );
  }
}
