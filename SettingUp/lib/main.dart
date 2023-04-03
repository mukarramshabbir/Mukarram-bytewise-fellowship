import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Lottery App'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ],
          )),
    );
  }
}

/*Row(
children: [
Expanded(
flex: 2,
child: Container(
color: Colors.red,
height: 250,
child: Center(child: Text('Container 1')),
),),
Expanded(
flex: 3,
child: Container(
color: Colors.grey,
height: 250,
child: Center(child: Text('Container 1')),
),
),

],
),
Expanded(

child:Center(

child: Container(
height: 200,
width: 200,
transform: Matrix4.rotationZ(.2),
padding: EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.orange,
borderRadius: BorderRadius.circular(10),
border: Border.all(
color: Colors.red,
width: 0,

),
image: DecorationImage(
fit: BoxFit.fill,
image: NetworkImage('https://images.pexels.com/photos/3742639/pexels-photo-3742639.jpeg?auto=compress&cs=tinysrgb&w=800'),
),
boxShadow: [
BoxShadow(
color: Colors.grey,
blurRadius:20
)
]
),
child:Center(child: Text('Login')),
)
), ),


Stack widget

 Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    color: Colors.red,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    color: Colors.green,
                  )
                ],
              )

SizedBox(
                height: 100,
              ),
              Divider(
                color: Colors.black,
                thickness: 3,
              ),
              SizedBox(
                height: 100,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 3,
                ),
              ),
              Center(
                child: CircleAvatar(
                  minRadius: 20,
                  maxRadius: 100,
                  child: Icon(Icons.person),
                  backgroundImage: NetworkImage('https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&w=800'),
                ),
              ),
Center(
                child: RichText(text: TextSpan(
                  text: 'Dont have an account?',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(text: 'Sign Up',style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold,fontSize: 20))
                  ]
                )),
              )

 */
