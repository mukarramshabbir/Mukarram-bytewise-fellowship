import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp(),));

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
      home: MyHomePage(),
    );
  }
}
final counterStateProvider=StateProvider<int>((ref){
  return 0;
});

class MyHomePage extends ConsumerWidget{
  @override
  Widget build(BuildContext context,WidgetRef ref){
    var value=ref.watch(counterStateProvider);
    return Scaffold(
      body: Center(
        child: Text(
          'value: $value',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () => ref.read(counterStateProvider.state).state++,
                child: Icon(Icons.add),
            ),
            Expanded(child: Container()),
            FloatingActionButton(
                onPressed: () => ref.read(counterStateProvider.state).state--,
              child: Icon(Icons.remove),
            )
          ],
        ),
      ),

    );
  }
}