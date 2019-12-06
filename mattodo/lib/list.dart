import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'globals.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todo.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeCounter(String list) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(list);
  }
}

class TodoList extends StatefulWidget {
  final CounterStorage storage;

  TodoList({Key key, @required this.storage}) : super(key: key);
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  
  List<String> _todoItems = [];
  Future<File> _addTodoItem(String task) {
    if(task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => _todoItems.add(task));
    }

    // Write the variable as a string to the file.
    String temp = _todoItems.toString();
    return widget.storage.writeCounter(temp.substring(1,temp.length-1).replaceAll(",","`"));
  }

  Future<File> _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));

    String temp = _todoItems.toString();
    return widget.storage.writeCounter(temp.substring(1,temp.length-1).replaceAll(",","`"));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              // The alert is actually part of the navigation stack, so to close it, we
              // need to pop it.
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new Dismissible(
      key: Key(_todoItems[index]),
      background: Container(color: Colors.green,
        child: new Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      ),
      onDismissed: (DismissDirection swipedir){
        setState(() {
          _removeTodoItem(index);
        });
      },
      child: ListTile(
        title: new Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
      ),
    );
    
     
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((String value) {
      setState(() {
        if(!(value=="")){
           _todoItems = value.split("` ");
           print(value);
        }
         
      });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          _pushAddTodoScreen();
        },
        child: _buildTodoList(),
      ),
      
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0),
              ),
            )
          );
        }
      )
    );
  }
}