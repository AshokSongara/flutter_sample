import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

const files = [
  "https://adoddleqaak.asite.com/lnk/a7RRECyyqGnIBXgKE",
  "https://adoddleqaak.asite.com/lnk/5a66bhyyMRouq5xnB",
  // "https://adoddleqaak.asite.com/lnk/7a667FyyMREf57xnB",
  // "https://adoddleqaak.asite.com/lnk/ya66Xt55ExgCpL7jK",
  // "https://adoddleqaak.asite.com/lnk/zaEEBsyy94MU7RxgA",
  // "https://adoddleqaak.asite.com/lnk/g7MMjfyyqGjhK4d9X",
  // "https://adoddleqaak.asite.com/lnk/oLEEzIEErqEtp6oEn",
  // "https://adoddleqaak.asite.com/lnk/7a66KCyyMrBU57xnB",
  // "https://adoddleqaak.asite.com/lnk/kaEEAIEEjqnFp6kEn",
  // "https://adoddleqaak.asite.com/lnk/K9rr6h99aoytnL7My",
  // "https://adoddleqaak.asite.com/lnk/r766nSyyMjdC8az7K",
  // "https://adoddleqaak.asite.com/lnk/oLEEeuEErq6fp6oEn",
  // "https://adoddleqaak.asite.com/lnk/jL66oU66bzXI6b8oL",
  // "https://adoddleqaak.asite.com/lnk/87EE9Syy9p9szRxgA",
  // "https://adoddleqaak.asite.com/lnk/LKzzoHRRjLgHRAqd5",
  // "https://adoddleqaak.asite.com/lnk/qa66zsyyMrrF5qxnB",
  // "https://adoddleqaak.asite.com/lnk/jL667f66bz8S6b8oL",
  // "https://adoddleqaak.asite.com/lnk/G9777Idd9yKskqMBp",
  // "https://adoddleqaak.asite.com/lnk/b7RRyHyyozjHdB6Ka",
  // "https://adoddleqaak.asite.com/lnk/976yLFyyEdyHpazLK",
  // "https://adoddleqaak.asite.com/lnk/jL65qU66bept6b8oL",
  // "https://adoddleqaak.asite.com/lnk/G97AKsdd9qMUkqMBp",
  // "https://adoddleqaak.asite.com/lnk/67Ay9SyyErxSeaz79",
  // "https://adoddleqaak.asite.com/lnk/g7MynSyyqB7IK4d9X",
  // "https://adoddleqaak.asite.com/lnk/oLE5jIEEr8Gsp6oEn",
  // "https://adoddleqaak.asite.com/lnk/d7MyAuyyo7oC6BAKa",
  // "https://adoddleqaak.asite.com/lnk/X7R5MURRqGBHL4gKE",
  // "https://adoddleqaak.asite.com/lnk/K9rX9f99aGofnL7My",
  // "https://adoddleqaak.asite.com/lnk/qa6ydHyyMKKU5qxnB",
  // "https://adoddleqaak.asite.com/lnk/p76yRCyyMrRseaz79",
  // "https://adoddleqaak.asite.com/lnk/nL65xF66beGt6b8oL",
  // "https://adoddleqaak.asite.com/lnk/7a6y7IyyMKoS57xnB",
  // "https://adoddleqaak.asite.com/lnk/ya65Xt55Ed4SpL7jK",
  // "https://adoddleqaak.asite.com/lnk/zaEyBuyy9KXh7RxgA",
  // "https://adoddleqaak.asite.com/lnk/r76ykhyyMk7I8az7K",
  // "https://adoddleqaak.asite.com/lnk/oLE5zhEEr8yFp6oEn",
  // "https://adoddleqaak.asite.com/lnk/d7MyLsyyo7gC6BAKa",
  // "https://adoddleqaak.asite.com/lnk/X7R5qURRqGMHL4gKE",
  // "https://adoddleqaak.asite.com/lnk/LKzAkCRRjkMCRAqd5",
  // "https://adoddleqaak.asite.com/lnk/M9r46H99aGkUnL7Ey",
  // "https://adoddleqaak.asite.com/lnk/p76ykCyyMreseaz79",
  // "https://adoddleqaak.asite.com/lnk/nL65KI66beqF6b8oL",
  // "https://adoddleqaak.asite.com/lnk/7a6y5FyyMKxh57xnB",
  // "https://adoddleqaak.asite.com/lnk/b7Ryxuyyo7judB6Ka",
  // "https://adoddleqaak.asite.com/lnk/kaE5xFEEj46sp6kEn",
  // "https://adoddleqaak.asite.com/lnk/K9rXbs99aebUnL7My",
  // "https://adoddleqaak.asite.com/lnk/r76yqUyyMRMF8az7K",
  // "https://adoddleqaak.asite.com/lnk/LKA7MCRRjyyCRAqd5",
  // "https://adoddleqaak.asite.com/lnk/d7MyytyyopzS6BAKa",
  // "https://adoddleqaak.asite.com/lnk/G9A88hdd9xqSkqMBp"
];

String localPath = "";

Future<String> prepareSaveDir() async {
  localPath = (await findLocalPath())!;
  final savedDir = io.Directory(localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
  return localPath;
}

Future<String?> findLocalPath() async {
  io.Directory? directory;
  try {
    if (io.Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = io.Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists()) {
        directory.create();
      }
      directory = await getExternalStorageDirectory();
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}

Future<List<io.FileSystemEntity>> getLocalDownloadedFile() async {
  String path = (await findLocalPath())!;
  final savedDir = io.Directory(path).listSync();
  return savedDir;
}
