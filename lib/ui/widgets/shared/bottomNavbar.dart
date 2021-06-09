import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/routes/router.gr.dart';
import 'package:todo/ui/shared/styles.dart';
import 'package:todo/core/models/todo.dart';
import 'package:todo/core/services/provider/todo_provider.dart';

class TodoNavBar extends StatefulWidget {
  final bool isProfile;

  TodoNavBar({required this.isProfile});

  @override
  _TodoNavBarState createState() => _TodoNavBarState();
}

class _TodoNavBarState extends State<TodoNavBar> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(
                Icons.folder,
                size: 30,
                color: widget.isProfile
                    ? Theme.of(context).accentIconTheme.color
                    : Theme.of(context).iconTheme.color,
              ),
              Text('To Do',
                  style: widget.isProfile
                      ? kNavBarInActiveTextStyle
                      : kNavBarActiveTextStyle),
            ],
          ),
          InkWell(
            onTap: () {
              todoProvider.selectedTodo = TodoModel(
                details: 'details',
                category: 'Study',
                title: 'title',
                date: DateTime.now(),
              );
              AutoRouter.of(context).push(TodoEditRoute());
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(ProfileRoute());
            },
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: widget.isProfile
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).accentIconTheme.color,
                ),
                Text('Profile',
                    style: widget.isProfile
                        ? kNavBarActiveTextStyle
                        : kNavBarInActiveTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
