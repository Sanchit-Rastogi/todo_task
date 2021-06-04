final todoTable = 'todo';

class TodoFields {
  static final List<String> values = [id, title, category, details, date];

  static final String id = '_id';
  static final String title = 'title';
  static final String category = 'category';
  static final String details = 'details';
  static final String date = 'date';
}

class TodoModel {
  int? id;
  String title;
  String category;
  String details;
  DateTime date;

  TodoModel({
    this.id,
    required this.details,
    required this.category,
    required this.title,
    required this.date,
  });

  TodoModel copy({
    int? id,
    String? title,
    String? category,
    String? details,
    DateTime? date,
  }) =>
      TodoModel(
        id: id ?? this.id,
        details: details ?? this.details,
        category: category ?? this.category,
        title: title ?? this.title,
        date: date ?? this.date,
      );

  static TodoModel fromJson(Map<String, Object?> json) => TodoModel(
        id: json[TodoFields.id] as int?,
        details: json[TodoFields.details] as String,
        category: json[TodoFields.category] as String,
        title: json[TodoFields.title] as String,
        date: DateTime.parse(json[TodoFields.date] as String),
      );

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.title: title,
        TodoFields.category: category,
        TodoFields.details: details,
        TodoFields.date: date.toIso8601String(),
      };
}
