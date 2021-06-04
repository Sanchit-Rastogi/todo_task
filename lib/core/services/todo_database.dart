import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/core/models/todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;
  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('todo.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $todoTable(
    ${TodoFields.id} $idType,
    ${TodoFields.title} $textType,
    ${TodoFields.category} $textType,
    ${TodoFields.details} $textType,
    ${TodoFields.date} $textType
    )
    ''');
  }

  Future<TodoModel> create(TodoModel todo) async {
    final db = await instance.database;

    final id = await db.insert(todoTable, todo.toJson());
    return todo.copy(id: id);
  }

  Future<TodoModel> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      todoTable,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TodoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TodoModel>> readAllTodo() async {
    final db = await instance.database;

    final orderBy = '${TodoFields.date} ASC';
    final result = await db.query(todoTable, orderBy: orderBy);

    return result.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<int> update(TodoModel todo) async {
    final db = await instance.database;

    return db.update(
      todoTable,
      todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      todoTable,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
