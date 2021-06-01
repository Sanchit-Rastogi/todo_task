import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/styles.dart';
import 'package:todo/models/todoModel.dart';
import 'package:todo/provider/todo_provider.dart';

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
                color: widget.isProfile ? Theme.of(context).accentIconTheme.color : Theme.of(context).iconTheme.color,
              ),
              Text('To Do', style: widget.isProfile ? kNavBarInActiveTextStyle : kNavBarActiveTextStyle),
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
              Navigator.pushNamed(context, 'todoEdit');
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
              Navigator.pushNamed(context, 'profile');
            },
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: widget.isProfile ? Theme.of(context).iconTheme.color : Theme.of(context).accentIconTheme.color,
                ),
                Text('Profile', style: widget.isProfile ? kNavBarActiveTextStyle : kNavBarInActiveTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
