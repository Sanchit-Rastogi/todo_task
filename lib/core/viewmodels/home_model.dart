import 'package:flutter/cupertino.dart';
import 'package:todo/core/models/todo.dart';
import 'package:todo/core/services/provider/todo_provider.dart';

import '../../locator.dart';

class HomeModel extends ChangeNotifier {
  List<TodoModel> todoList = [];

  void loadTodo() async {
    await locator<TodoProvider>().loadTodo();
    todoList = locator<TodoProvider>().todoList;
    notifyListeners();
  }
}
