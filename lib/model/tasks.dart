class Task {
  final String title;
  final String content;
  final String date;
  final String time;
  final String repeat;
  final String category;
  final String id;
  final int isCompleted;

  Task(
      {required this.title,
      required this.content,
      required this.time,
        required this.isCompleted,
      required this.date,
      required this.repeat,
      required this.category, required this.id});
}
