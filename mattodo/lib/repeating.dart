import 'package:flutter/material.dart';

class Repeat extends StatefulWidget{

  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat>{
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}