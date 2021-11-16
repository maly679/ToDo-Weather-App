import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String title;
  TodoItem({this.title});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
        });
      },
      child: Container(
        // Checkmark task
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: ListTile(
          leading: isDone ? Icon(Icons.check) : SizedBox(),
          title: Text(
            widget.title,
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
