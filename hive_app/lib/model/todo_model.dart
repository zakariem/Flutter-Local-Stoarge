import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}
