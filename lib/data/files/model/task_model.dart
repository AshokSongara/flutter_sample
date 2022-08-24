import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String filename;
  @HiveField(2)
  int status;

  TaskModel({required this.id, required this.filename, required this.status});
}
