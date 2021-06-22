import 'package:flutter/material.dart';
import 'package:todo/core/services/provider/todo_provider.dart';

import '../../locator.dart';

class TodoDetailsModel extends ChangeNotifier {
  final todo = locator<TodoProvider>().selectedTodo;
}
