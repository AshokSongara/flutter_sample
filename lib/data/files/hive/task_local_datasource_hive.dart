import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_practical/data/files/model/task_model.dart';
import 'package:flutter_practical/data/files/task_local_datasource.dart';
import 'package:flutter_practical/domain/files/task/task.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

class TaskModelLocalDatasourceHiveImpl implements TaskModelLocalDatasource {
  final _kTaskModelsBoxName = 'task_box';

  @override
  Future<bool> initDb() async {
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }

      Hive.registerAdapter(TaskModelAdapter());
      await Hive.openBox<TaskModel>(_kTaskModelsBoxName);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<TaskModel>> getTaskModels() async {
    // return task hive box
    final taskBox = await Hive.openBox<TaskModel>(_kTaskModelsBoxName);
    var fileList = taskBox.values.map<TaskModel>((e) {
      return TaskModel(id: e.id, filename: e.filename, status: e.status);
    }).toList();
   // taskBox.close();
    return fileList;
  }

  @override
  Future<bool> insertTaskModel(TaskModel tasks) async {
    try {
      //  Hive.registerAdapter(TaskModelAdapter());
      final tasksBox = await Hive.openBox<TaskModel>(_kTaskModelsBoxName);
      await tasksBox.put(tasks.id, tasks);
     // await tasksBox.close();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllTaskModel() async {
    try {
      final tasksBox = Hive.box<TaskModel>(_kTaskModelsBoxName);
      final deleted = await tasksBox.clear();
      // print deleted entries
      print('delete $deleted entries from hive $_kTaskModelsBoxName box');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteDb() async {
    // TODO: implement deleteDb
    throw UnimplementedError();
  }
}
