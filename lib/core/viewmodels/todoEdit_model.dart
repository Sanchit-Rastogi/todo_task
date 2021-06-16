import 'package:flutter/material.dart';
import 'package:todo/core/models/todo.dart';
import 'package:todo/core/services/provider/todo_provider.dart';
import 'package:todo/locator.dart';

class TodoEditModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  String selectedCategory = "Fun";

  List<String> categories = [
    'Work',
    'Fun',
    'Sport',
    'Study',
    'Family',
    'Birth'
  ];

  Map<String, bool> categorySelection = {
    'Work': false,
    'Fun': true,
    'Sport': false,
    'Study': false,
    'Family': false,
    'Birth': false,
  };

  void onInit() {
    final selectedTodo = locator<TodoProvider>().selectedTodo;
    selectedCategory = selectedTodo.category;
    selectedDay = selectedTodo.date;
    changeCategory(selectedCategory);
  }

  void changeCategory(String cat) {
    categorySelection.forEach((key, value) {
      if (key == cat) {
        categorySelection[key] = true;
        selectedCategory = cat;
      } else
        categorySelection[key] = false;
    });
    notifyListeners();
  }

  void updateOrAdd(TodoModel todo) {
    final todoProvider = locator<TodoProvider>();
    print(todo.id);
    print(todoProvider.selectedTodo.id);
    if (todoProvider.selectedTodo.id != null) {
      print('updated');
      todoProvider.updateTodo(todo);
    } else {
      print('created');
      todoProvider.addTodo(todo);
    }
  }
}
