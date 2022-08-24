import 'package:flutter_practical/data/files/model/task_model.dart';

abstract class TaskModelLocalDatasource {
  Future<bool> initDb();
  Future<bool> deleteDb();
  Future<bool> insertTaskModel(TaskModel taskModels);
  Future<bool> deleteAllTaskModel();
  Future<List<TaskModel>> getTaskModels();
}