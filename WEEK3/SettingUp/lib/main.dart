import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SideMenu(),

    );
  }
}


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        height: double.infinity,
        color: Colors.black87,
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Icon(Icons.person,color: Colors.black87,),
                ),
                title: Text(
                  'Mukarram Ali',
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  'App Developer',
                    style: TextStyle(color: Colors.white70),
                ),
              )
            ],
          ),
        ),
      ),
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

Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 14,color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.red
                    ),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    print(value);
                  },
                ),

              ),

              int level=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery App'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage('https://images.pexels.com/photos/3742639/pexels-photo-3742639.jpeg?auto=compress&cs=tinysrgb&w=800'),
                    ),
                    title: Text('Mukarram Ali'),
                    subtitle: Text('Subscribe to channel $level'),
                    trailing: Text('3.51pm'),
                  );
                }
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            level+=1;
          });
        },
        child: Icon(Icons.add),

        backgroundColor: Colors.orange,

      ),
    );
  }
 */
