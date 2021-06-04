import 'package:flutter/material.dart';
import 'package:todo/core/services/todo_database.dart';
import 'package:todo/core/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  TodoModel selectedTodo = TodoModel(
    details: 'details',
    category: 'Study',
    title: 'title',
    date: DateTime.now(),
  );

  List<TodoModel> todoList = [];

  Future addTodo(TodoModel todo) async {
    await TodoDatabase.instance.create(todo);
    notifyListeners();
  }

  Future updateTodo(TodoModel todo) async {
    await TodoDatabase.instance.update(todo);
    notifyListeners();
  }

  Future deleteTodo(int id) async {
    await TodoDatabase.instance.delete(id);
    notifyListeners();
  }

  Future loadTodo() async {
    todoList = await TodoDatabase.instance.readAllTodo();
    notifyListeners();
  }
}
