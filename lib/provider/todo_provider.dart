import 'package:flutter/material.dart';
import 'package:todo/models/todoModel.dart';

class TodoProvider extends ChangeNotifier {
  TodoModel selectedTodo = TodoModel(
    details: 'details',
    category: 'category',
    title: 'title',
    date: DateTime.now(),
  );

  List<TodoModel> todoList = [
    TodoModel(
      details: 'Remember to travel to japan in May to pack up your luggage and then remind your girlfriend to bring your passport and other information.',
      category: 'Family',
      title: 'Japan Tourism',
      date: DateTime.now(),
    ),
    TodoModel(
      details: 'details',
      category: 'Fun',
      title: 'title',
      date: DateTime.now(),
    ),
    TodoModel(
      details: 'details',
      category: 'Sport',
      title: 'title',
      date: DateTime.now(),
    ),
    TodoModel(
      details: 'details',
      category: 'Work',
      title: 'title',
      date: DateTime.now(),
    ),
    TodoModel(
      details: 'details',
      category: 'Birth',
      title: 'title',
      date: DateTime.now(),
    ),
    TodoModel(
      details: 'details',
      category: 'Study',
      title: 'title',
      date: DateTime.now(),
    ),
  ];

  void addTodo(TodoModel todo) {
    todoList.add(todo);
    notifyListeners();
  }
}
