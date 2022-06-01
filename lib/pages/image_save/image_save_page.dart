
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_app_settings/open_app_settings.dart';

import '../../utils/toast_util.dart';


class ImageSavePage extends StatefulWidget {
  const ImageSavePage({Key? key}) : super(key: key);

  @override
  State<ImageSavePage> createState() => _ImageSavePageState();
}

class _ImageSavePageState extends State<ImageSavePage> {
  final GlobalKey _globalKey = GlobalKey();


  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    super.initState();
  }

  Future<void> savePicture (String pictureUrl, String pictureName) async {

    //1、权限检查
    if(await Permission.storage.request().isGranted){

      var response = await Dio().get(pictureUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),name: pictureName);
      print('result:$result');

      bool isSuccessSave = result["isSuccess"];
      ToastUtils.toast(isSuccessSave?"已保存至相册":"保存失败");
    }else{
      if(Platform.isIOS){
        ToastUtils.toast("请去设置-开启照片权限");
      } else {
        ToastUtils.toast("请去设置-开启存储权限");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保存图片到本地'),
      ),
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存APP里的图片'),
            ),
          ),
          RepaintBoundary(
            key: _globalKey,
            child: InkWell(
                onTap: () {
                  checkPermission(saveAssetsImg());
                },
                child: Image.asset(
                  'assets/images/head_icon02.png',
                  height: 200,
                )),
          ),
          const SizedBox(height: 20,),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存网络图片'),
            ),
          ),
          SizedBox(
            width: 200,
            height: 100,
            child: InkWell(
                onTap: () {
                  checkPermission(saveNetworkImg(
                      "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg"));
                  },
                child: Image.network(
                    "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('保存gif动画'),
            ),
          ),
          SizedBox(
            width: 200,
            height: 80,
            child: InkWell(
                onTap: () {
                  checkPermission(savegif(
                      "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif"));
                },
                child: Image.network(
                  "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif",
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                checkPermission(saveVideo());
              },
              child: const Text('保存视频')),
          ElevatedButton(
              onPressed: () {
                _getGalleryImage();
              },
              child: const Text('获取图片')),

        ],
      ),
    );
  }

  // 动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {

    //1、权限检查
    if(await Permission.storage.request().isGranted){
      return true;
    }else{
      if(Platform.isIOS){
        ToastUtils.toast("请去设置-开启照片权限");
      } else {
        ToastUtils.toast("请去设置-开启存储权限");
      }
      return false;
    }


    /*if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        await [
          Permission.photos,
        ].request();
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }*/

  }

  // 保存图片的权限校验
  checkPermission(Future<dynamic> fun) {
    requestPermission().then((value) {
      if (value) {
          // 执行操作
        fun;
      }
      else {
          // 去授权 存储权限
          OpenAppSettings.openAppSettings();
        }
    });
  }
  checkPermissionMethod(Future<dynamic> fun) {
    requestPermission().then((value) => {
      if (value)
        {
          // 执行操作
          fun
        }
      else
        {
          // 去授权 存储权限
          OpenAppSettings.openAppSettings()
        }
    });
  }


  // 保存APP里的图片
  saveAssetsImg() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
    await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List(),isReturnImagePathOfIOS: true);
      print(result);
      if (result['isSuccess']) {
        Fluttertoast.showToast(msg: "保存APP里的图片成功，保存路径为${result['filePath']}");
      }
    }
  }

  // 保存网络图片
  saveNetworkImg(String imgUrl) async {
    var response = await Dio()
        .get(imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    if (result['isSuccess']) {
      print(result);
      Fluttertoast.showToast(msg: "保存网络图片成功，保存路径为${result['filePath']}");
    }
  }

  // 保存gif动画
  savegif(String imgUrl) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.gif";
    String fileUrl = imgUrl;
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath,isReturnPathOfIOS: true);
    if (result['isSuccess']) {
      print(result);
      Fluttertoast.showToast(msg: "保存gif动画成功，保存路径为${result['filePath']}");
    }
  }

  // 保存视频
  saveVideo() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    String fileUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    if (result['isSuccess']) {
      Fluttertoast.showToast(msg: "保存视频成功，保存路径为${result['filePath']}");
    }
  }

  //获取相册中的file

  ///选择图片 上传
  void _getGalleryImage() async{
    print("选择图片上传时间 = ${DateTime.now()}");

    final pickImage = await picker.pickImage(source: ImageSource.gallery,maxHeight: 1280,maxWidth: 720);
    print("选择图片上传 = $pickImage");
    if(pickImage != null){
      String imagedPath = pickImage.path;
      print("选择图片上传 = $pickImage");

    }

  }





}




