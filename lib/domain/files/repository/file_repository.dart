import '../task/task.dart';

abstract class FileRepository {
  Future<List<String>> downloadFiles(List<String> fileList);

  Future<List<Task>> getDownloadedFiles();
}
