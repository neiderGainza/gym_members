import 'package:flutter/material.dart';
import 'package:general_list/general_list.dart';

void main() {
  runApp(const Gym());
}

class Gym extends StatelessWidget {
  const Gym({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: GeneralList<int>(
        itemBuilder: (context, item){
          return Card(
            child: Text(item.toString()),
          );
        }, 
        getItems: () async *{
          yield [ for(int i = 0; i < 10; i++) i];
        }
      ),
    );
  }
}
