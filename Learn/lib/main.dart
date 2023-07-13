import 'package:flutter/material.dart';
import 'package:learn/widgets/rounded_btn.dart';

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
  var arrColor=[Colors.red,Colors.orange,Colors.grey,Colors.green,Colors.black];
  void callBack(){
    print('Clicked');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 70,
              child: RoundedButton(btnName: 'LOGIN',
                icon: Icon(Icons.login),
                callback: (){
                print('Clicked');
              },
              ),
            ),
            Container(height: 50,),
            Container(
              width: 120,
              height: 70,
              child: RoundedButton(btnName: 'Sign Up',
                icon: Icon(Icons.sign_language),
                bgColor: Colors.orange,
                callback: (){
                  print('Clicked');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatItems extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.blue,
        child: ListView.builder(itemBuilder: (context,index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 70,
            child: CircleAvatar(
              backgroundColor: Colors.green,
            ),
          ),
        ),itemCount: 10,scrollDirection: Axis.horizontal,),
      ),
    );
  }
}

class Contact extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 4,
      child: Container(
        color: Colors.blueGrey,
        child: ListView.builder(itemBuilder: (context,index) => Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
            ),
            title: Text('Mukarram'),
            subtitle: Text('Ali'),
            trailing: Icon(Icons.add),
          ),
        ),
        ),
      ),
    );
  }
}

class SubCatItem extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        child: ListView.builder(itemBuilder: (context,index) =>
            Padding(padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.blue,
                ),
              ),
            ),itemCount: 10,scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class BottomMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 2,
      child: Container(
          color: Colors.green,
          child: GridView.count(crossAxisCount: 4,
            children: [
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}