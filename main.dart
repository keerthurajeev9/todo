import 'package:flutter/material.dart';

// Code written in Dart starts exectuting from the main function. runApp is part of
// Flutter, and requires the component which will be our app's container. In Flutter,
// every component is known as a "widget".
void main() => runApp(new TodoApp());

// Every component in Flutter is a widget, even the whole app itself
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new Todo()
    );
  }
}

class Todo extends StatefulWidget {
  @override
  createState() => new TodoState();
}

class TodoState extends State<Todo> {
  List<String> _todoItems = [];

  void _add(String i) {

    if (i.length > 0) {

      setState(() => _todoItems.add(i));
    }
  }

  void _delete(int pos) {
    setState(() => _todoItems.removeAt(pos));
  }

  void _removing(int i) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Is the task done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('Cancel it'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('Done'),
                    onPressed: () {
                      _delete(i);
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
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText),
        onTap: () => _removing(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket,
            size:35.0,
            color: Colors.blueGrey,

            ),
          ),
        ],
        title:
        new Text('Todo List',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add,
          color: Colors.black,)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(

        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                    backgroundColor: Colors.black,
                      title: new Text('Add the task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _add(val);
                      Navigator.pop(context);
                    },
                    decoration: new InputDecoration(


                        icon: Icon(Icons.shopping_basket,
                        size:25.0,),
                        hintText: 'Enter the desired task',
                        contentPadding: const EdgeInsets.all(19.0)
                    ),
                  )
              );
            }
        )
    );
  }
}
