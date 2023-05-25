import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week08/main.dart';

class MyHomePage extends ConsumerWidget{
  const MyHomePage({Key? key}) : super(key: key);

  void onSubmit(WidgetRef ref, String value){
    ref.read(nameProvider.notifier).update((state) => value);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final name=ref.watch(nameProvider) ?? '';
    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: Column(
        children: [
          TextField(onSubmitted: (value)=> onSubmit(ref, value),),
          Center(
            child: Text(name),
          )
        ],
      ),
    );
  }
}