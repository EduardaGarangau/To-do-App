class TodoModel {
  final String id;
  final String title;
  final DateTime date;
  bool completed;

  TodoModel({
    required this.id,
    required this.title,
    required this.date,
    this.completed = false,
  });
}
