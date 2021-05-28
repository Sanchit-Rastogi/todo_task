import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/colorMap.dart';
import 'package:todo/constants/extensions.dart';
import 'package:todo/constants/styles.dart';
import 'package:todo/models/todoModel.dart';
import 'package:todo/provider/todo_provider.dart';

class TodoBox extends StatelessWidget {
  final TodoModel todo;

  TodoBox({required this.todo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'todoDetails');
        Provider.of<TodoProvider>(context, listen: false).selectedTodo = todo;
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20),
        height: 100,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorMap[todo.category],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              width: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(todo.date.day.toString(), style: colorMap[todo.category] == Colors.black ? kTodoBoxWhiteDateTextStyle : kTodoBoxBlackDateTextStyle),
                  Text(todo.date.month.name(), style: colorMap[todo.category] == Colors.black ? kTodoBoxWhiteDateTextStyle : kTodoBoxBlackDateTextStyle),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todo.title,
                    style: kTodoBoxTitleTextStyle,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    child: Text(
                      todo.category,
                      style: kTodoBoxCategoryTextStyle,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorMap[todo.category] ?? kWorkColor, width: 2),
                    ),
                  ),
                  Text(
                    todo.details,
                    style: kTodoBoxDetailsTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
