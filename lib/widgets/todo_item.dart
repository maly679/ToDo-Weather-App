import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String? title;

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
        child: CheckboxListTile(
          title: Text(
            widget.title.toString(),
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          secondary: Icon(Icons.checklist),
          controlAffinity:
          ListTileControlAffinity.leading,
          value: isDone,
          onChanged: (bool? value) {
            setState(() {
              isDone = value!;
            });
          },
          activeColor: Colors.green,
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
