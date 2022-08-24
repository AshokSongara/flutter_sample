import 'package:flutter_practical/common/app_utils.dart';
import 'package:flutter_practical/domain/base/base_usecase.dart';
import 'package:flutter_practical/domain/files/repository/file_repository.dart';

class DownloadFileUseCase extends BaseUseCase<List<String>> {
  FileRepository fileRepository;

  DownloadFileUseCase(this.fileRepository);

  @override
  Future<List<String>> perform() {
    return fileRepository.downloadFiles(files);
  }
}
