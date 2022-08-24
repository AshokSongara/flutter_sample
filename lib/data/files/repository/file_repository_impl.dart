import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_practical/data/files/model/task_model.dart';
import 'package:flutter_practical/data/files/task_local_datasource.dart';
import 'package:flutter_practical/domain/files/repository/file_repository.dart';
import 'package:flutter_practical/domain/files/task/task.dart';

import '../../../common/app_utils.dart';

class FileRepositoryImpl extends FileRepository {
  final TaskModelLocalDatasource taskModelLocalDatasource;

  FileRepositoryImpl({required this.taskModelLocalDatasource});

  @override
  Future<List<String>> downloadFiles(List<String> fileList) async {
    List<String> status = [];
    _requestDownload(fileList);
    return status;
  }

  void _requestDownload(List<String> files) async {
    for (var element in files) {
      var taskId = await FlutterDownloader.enqueue(
        url: element,
        savedDir: localPath,
        showNotification: false,
        openFileFromNotification: false,
        saveInPublicStorage: true,
      );

      if (taskId != null) {
        await taskModelLocalDatasource.insertTaskModel(
            TaskModel(id: taskId, filename: element, status: 1));
      }
      print("######Demo$taskId");
    }
  }

  @override
  Future<List<Task>> getDownloadedFiles() async {
    List<TaskModel>? dataList = [];
    List<Task>? filteredList = [];

    dataList = await taskModelLocalDatasource.getTaskModels();
    for (var element in dataList) {
      filteredList.add(Task(
          id: element.id, filename: element.filename, status: element.status));
    }
    return filteredList;
  }
}
