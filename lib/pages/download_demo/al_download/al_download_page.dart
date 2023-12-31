import 'package:flutter/material.dart';
import 'package:al_downloader/al_downloader.dart';

import 'download_model.dart';

class AlDownloadHomePage extends StatefulWidget {
  const AlDownloadHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AlDownloadHomePage> createState() => _AlDownloadPageState();
}

class _AlDownloadPageState extends State<AlDownloadHomePage> {
  @override
  void initState() {

    // Initialize downloader and get initial download status/progress.
    initialize();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "You are testing batch download",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(67, 68, 71, 1),
                    ),
                  ),
                  Expanded(child: theListview),
                ]),
            Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).padding.bottom + 10,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: theActionLists
                        .map((e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: MaterialButton(
                            padding: const EdgeInsets.all(0),
                            minWidth: 20,
                            height: 50,
                            child: Text(
                              e[0],
                              style: const TextStyle(fontSize: 10),
                            ),
                            color: Colors.blue,
                            textTheme: ButtonTextTheme.primary,
                            onPressed: e[1],
                          ),
                        )))
                        .toList()))
          ]),
    );
  }

  /// Core data in listView
  get theListview => ListView.separated(
    padding: EdgeInsets.only(
        top: 20, bottom: MediaQuery.of(context).padding.bottom + 75),
    shrinkWrap: true,
    itemCount: models.length,
    itemBuilder: (BuildContext context, int index) {
      final model = models[index];
      final order = index + 1;
      return Container(
        margin: const EdgeInsets.only(top: 12.0,bottom: 12.0,left: 16.0,right: 16.0),
        child: InkWell(
          onTap: (){
            if(model.status == ALDownloaderStatus.succeeded){
              getFilePath(model.url);
            }
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$order",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.url,
                      style: const TextStyle(fontSize: 11, color: Colors.black),
                    )),
                SizedBox(
                    height: 30,
                    child: Stack(fit: StackFit.expand, children: [
                      LinearProgressIndicator(
                        value: model.progress,
                        backgroundColor: Colors.grey,
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "progress = ${model.progressForPercent}",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          model.statusDescription,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                      )
                    ]))
              ]),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) =>
    const Divider(height: 10, color: Colors.transparent),
  );

  /// The action lists
  late final theActionLists = <List>[
    ["download", _downloadAllAction],
    ["pause", _pauseAllAction],
    ["cancel", _cancelAllAction],
    ["remove", _removeAllAction]
  ];

  /* ----------------------------------------------Action for test---------------------------------------------- */

  ///下载file所在路径
  Future<void> getFilePath(url) async {
    final model = await ALDownloaderPersistentFileManager.lazyGetALDownloaderPathModelForUrl(url);
    debugPrint(
        "ALDownloader | get the 'physical directory path' and 'virtual/physical file name' of the file for [url], url = $url, model = $model\n");

    final path2 = await ALDownloaderPersistentFileManager
        .lazyGetAbsolutePathOfDirectoryForUrl(url);
    debugPrint(
        "ALDownloader | get 'directory path' for [url], url = $url, path = $path2\n");

    final path3 = await ALDownloaderPersistentFileManager
        .getAbsoluteVirtualPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | get 'virtual file path' for [url], url = $url, path = $path3\n");

    final path4 = await ALDownloaderPersistentFileManager
        .getAbsolutePhysicalPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | get 'physical file path' for [url], url = $url, path = $path4\n");

    final isExist = await ALDownloaderPersistentFileManager
        .isExistAbsolutePhysicalPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | Check whether [url] exists a 'physical file path', url = $url, is Exist = $isExist\n");

    final fileName = ALDownloaderPersistentFileManager.getFileNameForUrl(url);
    debugPrint(
        "ALDownloader | get 'virtual/physical file name' for [url], url = $url, file name = $fileName\n");
  }


  /// Action
  // ignore: unused_element
  _downloadAction() async {
    await download();
  }

  /// Action
  // ignore: unused_element
  _downloadAllAction() async {
    await downloadAll();
  }

  /// Action
  // ignore: unused_element
  _pauseAction() async {
    final url = models.first.url;
    await ALDownloader.pause(url);
  }

  /// Action
  // ignore: unused_element
  _pauseAllAction() async {
    await ALDownloader.pauseAll();
  }

  /// Action
  // ignore: unused_element
  _cancelAction() async {
    final url = models.first.url;
    await ALDownloader.cancel(url);
  }

  /// Action
  _cancelAllAction() async {
    await ALDownloader.cancelAll();
  }

  /// Action
  // ignore: unused_element
  _removeAction() async {
    final url = models.first.url;
    await ALDownloader.remove(url);
  }

  /// Action
  // ignore: unused_element
  _removeAllAction() async {
    await ALDownloader.removeAll();
    initialize();
  }

  /* ----------------------------------------------Method for test---------------------------------------------- */

  /// Execute some methods together
  ///
  /// When executing the following methods together, try to keep them serial.
  Future<void> executeSomeMethodsTogether() async {
    await downloadAll();
    await path();
    await download();
    status();
  }

  /// Initialize
  Future<void> initialize() async {
    // Why [downloader interface] and [downloader interface for batch] are added before ALDownloader initialized?
    //
    // Because some downloads may download automatically when initializing, so downloader handler interface need
    // to be added before initialization to ensure that receive the information in the handler first time.

    // It is for download. It is a forever interface.
    addForeverDownloaderHandlerInterface();
    // It is for batch download. It is an one-off interface.
    addBatchDownloaderHandlerInterface();

    await ALDownloader.initialize();
  }

  /// Add a forever download handle interface 添加永久下载句柄接口
  void addForeverDownloaderHandlerInterface() {
    for (final model in models) {
      final url = model.url;
      ALDownloader.addForeverDownloaderHandlerInterface(
          ALDownloaderHandlerInterface(progressHandler: (progress) async {
            debugPrint(
                "ALDownloader | download progress = $progress, url = $url");

            model.status = ALDownloaderStatus.downloading;
            model.progress = progress;

            setState(() {

            });
          }, succeededHandler: () {
            debugPrint("ALDownloader | download succeeded, url = $url");

            model.status = ALDownloaderStatus.succeeded;

            setState(() {});
          }, failedHandler: () {
            debugPrint("ALDownloader | download failed, url = $url");

            model.status = ALDownloaderStatus.failed;

            setState(() {});
          }, pausedHandler: () {
            debugPrint("ALDownloader | download paused, url = $url");

            model.status = ALDownloaderStatus.paused;

            setState(() {});
          }),
          url);
    }
  }

  /// Add a download handle interface for batch 为批处理添加下载句柄接口
  void addBatchDownloaderHandlerInterface() {
    final urls = models.map((e) => e.url).toList();
    ALDownloaderBatcher.addDownloaderHandlerInterface(
        ALDownloaderHandlerInterface(progressHandler: (progress) {
          debugPrint("ALDownloader | batch | download progress = $progress");
        }, succeededHandler: () {
          debugPrint("ALDownloader | batch | download succeeded");
        }, failedHandler: () {
          debugPrint("ALDownloader | batch | download failed");
        }, pausedHandler: () {
          debugPrint("ALDownloader | batch | download paused");
        }),
        urls);
  }

  /// Download
  Future<void> download() async {
    final urls = models.map((e) => e.url).toList();
    final url = urls.first;

    await ALDownloader.download(url,
        downloaderHandlerInterface:
        ALDownloaderHandlerInterface(progressHandler: (progress) {
          debugPrint(
              "ALDownloader | download progress = $progress, url = $url");
        }, succeededHandler: () {
          debugPrint("ALDownloader | download succeeded, url = $url");
        }, failedHandler: () {
          debugPrint("ALDownloader | download failed, url = $url");
        }, pausedHandler: () {
          debugPrint("ALDownloader | download paused, url = $url");
        }));
  }

  /// Download all
  Future<void> downloadAll() async {
    final urls = models.map((e) => e.url).toList();
    await ALDownloaderBatcher.downloadUrls(urls,
        downloaderHandlerInterface:
        ALDownloaderHandlerInterface(progressHandler: (progress) {
          debugPrint("ALDownloader | batch | download progress = $progress");
        }, succeededHandler: () {
          debugPrint("ALDownloader | batch | download succeeded");

        }, failedHandler: () {
          debugPrint("ALDownloader | batch | download failed");
        }, pausedHandler: () {
          debugPrint("ALDownloader | batch | download paused");
        }));
  }

  /// Path
  Future<void> path() async {
    final urls = models.map((e) => e.url).toList();
    final url = urls.first;

    debugPrint('path -------- $urls');

    final model = await ALDownloaderPersistentFileManager
        .lazyGetALDownloaderPathModelForUrl(url);
    debugPrint(
        "ALDownloader | get the 'physical directory path' and 'virtual/physical file name' of the file for [url], url = $url, model = $model\n");

    final path2 = await ALDownloaderPersistentFileManager
        .lazyGetAbsolutePathOfDirectoryForUrl(url);
    debugPrint(
        "ALDownloader | get 'directory path' for [url], url = $url, path = $path2\n");

    final path3 = await ALDownloaderPersistentFileManager
        .getAbsoluteVirtualPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | get 'virtual file path' for [url], url = $url, path = $path3\n");

    final path4 = await ALDownloaderPersistentFileManager
        .getAbsolutePhysicalPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | get 'physical file path' for [url], url = $url, path = $path4\n");

    final isExist = await ALDownloaderPersistentFileManager
        .isExistAbsolutePhysicalPathOfFileForUrl(url);
    debugPrint(
        "ALDownloader | Check whether [url] exists a 'physical file path', url = $url, is Exist = $isExist\n");

    final fileName = ALDownloaderPersistentFileManager.getFileNameForUrl(url);
    debugPrint(
        "ALDownloader | get 'virtual/physical file name' for [url], url = $url, file name = $fileName\n");
  }

  /// Remove downloader handler interface
  void removeDownloaderHandlerInterface(String url) {
    final urls = models.map((e) => e.url).toList();
    final url = urls.first;
    ALDownloader.removeDownloaderHandlerInterfaceForUrl(url);
  }

  /// Remove all downloader handler interfaces
  void removeDownloaderHandlerInterfaceForAll() {
    ALDownloader.removeDownloaderHandlerInterfaceForAll();
  }

  /// Status
  void status() {
    final urls = models.map((e) => e.url).toList();
    final url = urls.first;

    ALDownloaderStatus status = ALDownloader.getDownloadStatusForUrl(url);
    debugPrint(
        "ALDownloader | get download status for [url], url = $url, status= $status\n");
  }
}