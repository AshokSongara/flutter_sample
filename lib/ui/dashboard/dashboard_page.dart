import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_practical/ui/dashboard/dashboard_viewmodel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  void _incrementCounter() {
    getLocalFiles();
  }

  final DashboardViewModel dashboardViewModel = DashboardViewModel();

  @override
  void initState() {
    super.initState();
    dashboardViewModel.checkPermission();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        dashboardViewModel.checkPermission();
      }
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image sample"),
      ),
      body: StreamBuilder<List<FileSystemEntity>?>(
          stream: dashboardViewModel.onCurrentFilesChanged,
          builder: (context, AsyncSnapshot<List<FileSystemEntity>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final FileSystemEntity chatItem = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      FlutterDownloader.open(taskId: chatItem.path);
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        // user name
                        child: chatItem.path != null
                            ? Image.file(File(chatItem.path))
                            : const Text("NoT Available")),
                  );
                },
              );
            } else {
              Container();
            }
            return const LinearProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    dashboardViewModel.closeObservable();
    super.dispose();
  }

  void getLocalFiles() {
    dashboardViewModel.getDoanloadedList();
  }
}
