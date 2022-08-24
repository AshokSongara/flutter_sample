import 'dart:async';
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_practical/data/files/hive/task_local_datasource_hive.dart';
import 'package:flutter_practical/data/files/repository/file_repository_impl.dart';
import 'package:flutter_practical/domain/files/usecase/download_file_usecase.dart';
import 'package:flutter_practical/domain/files/usecase/local_file_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/app_utils.dart';

class DashboardViewModel {
  var pokemonListSubject = PublishSubject<List<void>>();

  //var downloadedListSubject = PublishSubject<List<DownloadTask>>();
  StreamController<List<FileSystemEntity>> streamController =
      StreamController<List<FileSystemEntity>>();

  Stream<List<FileSystemEntity>> get onCurrentFilesChanged =>
      streamController.stream;

  Stream<List<void>> get pokemonList => pokemonListSubject.stream;

//  Stream<List<DownloadTask>> get downloadedList => downloadedListSubject.stream;

  DownloadFileUseCase downloadFileUseCase = DownloadFileUseCase(
      FileRepositoryImpl(
          taskModelLocalDatasource: TaskModelLocalDatasourceHiveImpl()));

  LocalFileUseCase localFileUseCase = LocalFileUseCase(FileRepositoryImpl(
      taskModelLocalDatasource: TaskModelLocalDatasourceHiveImpl()));

  void getFilesList() async {
    try {
      pokemonListSubject = PublishSubject<List<void>>();
      pokemonListSubject.sink.add(await downloadFileUseCase.perform());

      await Future.delayed(const Duration(seconds: 5), () {
        getDoanloadedList();
      });
    } catch (e) {
      pokemonListSubject.sink.addError(e);
    }
  }

  void getDoanloadedList() async {
    try {
      var list = await getLocalDownloadedFile();
      streamController.sink.add(list);
    } catch (e) {}
  }

  void initiateDownLoadListener() async {
    print("####Flutter----${await FlutterDownloader.loadTasks()}");
  }

  void closeObservable() {
    pokemonListSubject.close();
  }

  Future<bool> checkPermission() async {
    bool permissionStatus = false;
    var status = await Permission.storage.status;
    if (Platform.isIOS) {
      if (status.isGranted) {
        permissionStatus = true;
        await Permission.storage.request();
        getFilesList();
      } else if (status.isDenied) {
        await Permission.storage.request();
        permissionStatus = false;
      } else {
        openAppSettings();
      }
    } else {
      if (status.isDenied) {
        final tempStatus = await Permission.storage.request();
        if (tempStatus.isGranted) {
          getFilesList();
          return true;
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (status.isGranted) {
        permissionStatus = true;
        getFilesList();
        return permissionStatus;
      } else {
        openAppSettings();
      }
    }
    return permissionStatus;
  }
}
