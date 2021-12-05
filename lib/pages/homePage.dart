import 'package:flutter/material.dart';
import 'package:todo_list_weather/models/todo_model.dart';
import 'package:todo_list_weather/widgets/todo_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_weather/widgets/topWeather.dart';
import './loginPage.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  TextEditingController todoController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff00CC00),
      appBar: AppBar(
        backgroundColor: Color(0xff00CC00),
        title: Text('ToDo Weather App'),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text(
              'SIGN OUT',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              // Task List Heading Box

              Text(
                "<Test List>",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),

              Container(
                child: new Column(
                  children: <Widget>[
                    Row(children: [Expanded(child: new topWeather())]),
                    Row(children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 300,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: todoController,
                          decoration: InputDecoration.collapsed(
                              hintText: "Add a task..."),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(todoController.text);
                          setState(() {
                            todos.add(TodoModel(
                                title: todoController.text, isDone: false));
                            todoController.text = "";
                          });
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              //NOTE: Todo List
              Expanded(
                  child: Column(
                children: todos
                    .map((item) => TodoItem(
                          title: item.title,
                        ))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
