
import 'package:al_downloader/al_downloader.dart';
import 'package:flutter/material.dart';

/* ----------------------------------------------Model class for test---------------------------------------------- */

class DownloadModel {
  final String url;

  double progress = 0;

  bool get isSuccess => status == ALDownloaderStatus.succeeded;

  String get progressForPercent {
    progress = progress < 0 ? 0 : progress;
    //debugPrint('progress == $progress');
    int aProgress = (progress * 100).toInt();
    return "$aProgress%";
  }

  ALDownloaderStatus status = ALDownloaderStatus.unstarted;

  String get statusDescription {
    switch (status) {
      case ALDownloaderStatus.downloading:
        return "downloading";
      case ALDownloaderStatus.paused:
        return "paused";
      case ALDownloaderStatus.failed:
        return "failed";
      case ALDownloaderStatus.succeeded:
        return "succeeded";
      default:
        return "unstarted";
    }
  }

  DownloadModel(this.url);
}

/* ----------------------------------------------Data for test---------------------------------------------- */

final models = kTestVideos.map((e) => DownloadModel(e)).toList();

final kTestPNGs = [
  "https://upload-images.jianshu.io/upload_images/9955565-51a4b4f35bd7973f.png",
  "https://upload-images.jianshu.io/upload_images/9955565-e99b6bd33b388feb.png",
  "https://upload-images.jianshu.io/upload_images/9955565-3aafbc20dd329e58.png"
];

final kTestVideos = [
  "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
  "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
  "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
  "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
  "http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4",
  "http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4",
  "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
  "http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4",
  "http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4",
  "http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4",
  "http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4",
  "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4"
];

final kTestOthers = ["https://www.orimi.com/pdf-test.pdf"];
