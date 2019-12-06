import 'package:flutter/material.dart';
import 'drawer.dart';
import 'themes.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatefulWidget {
  @override
  _ToDoApp createState() => _ToDoApp();
}

class _ToDoApp extends State<ToDoApp>{
  ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();
  }

  Widget build(BuildContext context){
     return StreamBuilder<ThemeData>(
      initialData: _themeBloc.initialTheme().data,
      stream: _themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: 'Task',
          theme: snapshot.data,
          home: Home(
            themeBloc: _themeBloc,
          ),
        );
      },
    );
  }
}