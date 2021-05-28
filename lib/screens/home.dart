import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/styles.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/widgets/homePage/TodoBox.dart';
import 'package:todo/widgets/shared/bottomNavbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'To Do',
                style: kTodoHeadline,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var todo = todoProvider.todoList[index];
                      return TodoBox(todo: todo);
                    },
                    itemCount: todoProvider.todoList.length,
                  ),
                ),
              ),
              TodoNavBar(isProfile: false),
            ],
          ),
        ),
      ),
    );
  }
}
