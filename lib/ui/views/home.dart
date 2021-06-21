import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/db/todo_database.dart';
import 'package:todo/core/viewmodels/home_model.dart';
import 'package:todo/ui/shared/styles.dart';
import 'package:todo/ui/widgets/homePage/TodoBox.dart';
import 'package:todo/ui/widgets/shared/bottomNavbar.dart';

import '../../locator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final model = locator<HomeModel>();

  @override
  void initState() {
    model.loadTodo();
    super.initState();
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
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
                            var todo = model.todoList[index];
                            return TodoBox(todo: todo);
                          },
                          itemCount: model.todoList.length,
                        ),
                      ),
                    ),
                    TodoNavBar(isProfile: false),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
