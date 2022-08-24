import 'package:flutter_practical/common/app_utils.dart';
import 'package:flutter_practical/domain/base/base_usecase.dart';
import 'package:flutter_practical/domain/files/repository/file_repository.dart';

import '../task/task.dart';

class LocalFileUseCase extends BaseUseCase<List<Task>> {
  FileRepository fileRepository;

  LocalFileUseCase(this.fileRepository);

  @override
  Future<List<Task>> perform() {
    return fileRepository.getDownloadedFiles();
  }
}
