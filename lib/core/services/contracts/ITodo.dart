import 'package:todo/core/models/todo.dart';

abstract class ITodo {
  Future addTodo(TodoModel todo);

  Future updateTodo(TodoModel todo);

  Future deleteTodo(int id);

  Future loadTodo();
}
