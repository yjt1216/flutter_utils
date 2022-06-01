import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_utils/pages/bottom_bar/persistent_bottom/persistent_bottom_page.dart';
import 'package:flutter_utils/pages/dialog/bottom_keyboard_page.dart';
import 'package:flutter_utils/pages/dialog/dialog_page.dart';
import 'package:flutter_utils/pages/dialog_menu/company_menu.dart';
import 'package:flutter_utils/pages/download_demo/al_download/al_download_page.dart';
import 'package:flutter_utils/pages/grid_view/grid_page.dart';
import 'package:flutter_utils/pages/image_save/image_save_page.dart';
import 'package:flutter_utils/pages/keyboard_page/keyboard_content.dart';
import 'package:flutter_utils/pages/keyboard_page/sample.dart';
import 'package:flutter_utils/pages/keyboard_page/sample2.dart';
import 'package:flutter_utils/pages/keyboard_page/sample3.dart';
import 'package:flutter_utils/pages/keyboard_page/sample4.dart';
import 'package:get/get.dart';


void main() {
  // flutter_downloader 配置
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(
  //   //表示是否在控制台显示调试信息
  //   debug: true,
  //   ignoreSsl: true, // option: set to false to disable working with http links (default: false)
  //
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  _openWidget(BuildContext context, Widget widget) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => widget),
      );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //
      home: Scaffold(
        backgroundColor: Colors.amber,
        body: Builder(
          builder: (myContext) => Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: const Text("Full Screen form"),
                    onPressed: () => _openWidget(
                      myContext,
                      const ScaffoldTest(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Dialog form"),
                    onPressed: () => _openWidget(
                      myContext,
                      DialogTest(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Custom Sample 1"),
                    onPressed: () => _openWidget(
                      myContext,
                      Sample(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Custom Sample 2"),
                    onPressed: () => _openWidget(
                      myContext,
                      Sample2(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Custom Sample 3"),
                    onPressed: () => _openWidget(
                      myContext,
                      Sample3(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Custom Sample 4"),
                    onPressed: () => _openWidget(
                      myContext,
                      Sample4(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("FoldA"),
                    onPressed: () => _openWidget(
                      myContext,
                      const FoldA(),
                    ),
                  ),
                  //
                  ElevatedButton(
                    child: const Text("CustomGridPage"),
                    onPressed: () => _openWidget(
                      myContext,
                      const CustomGridPage(),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("CompanyBranch Test"),
                    onPressed: () {
                      Get.to(() => const CompanyBranchPage());
                    },
                  ),

                  ElevatedButton(
                    onPressed: (){
                      Get.to(() => const BottomKeyboardPage( title: '键盘遮挡问题',));
                    },
                    child: const Text('BottomKeyboardPage'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("ImageSavePage"),
                    onPressed: () => _openWidget(
                      myContext,
                      const ImageSavePage(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("AlDownloadHomePage"),
                    onPressed: () => _openWidget(
                      myContext,
                      const AlDownloadHomePage(title: '下载',),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text("Persistent Bottom Page"),
                    onPressed: () => _openWidget(
                      myContext,
                      PersistentBottomPage(menuScreenContext: context,),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      builder: FlutterSmartDialog.init(),
      onReady: (){
        debugPrint('init');
      },
    );
  }


}

/// Displays our [TextField]s in a [Scaffold] with a [FormKeyboardActions].
class ScaffoldTest extends StatelessWidget {
  const ScaffoldTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keyboard Actions Sample"),
      ),
      body: const Content(),
    );
  }
}

/// Displays our [FormKeyboardActions] nested in a [AlertDialog].
class DialogTest extends StatelessWidget {
  const DialogTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keyboard Actions Sample"),
      ),
      body: Center(
        child: TextButton(
          child: Text('Launch dialog'),
          onPressed: () => _launchInDialog(context),
        ),
      ),
    );
  }

  void _launchInDialog(BuildContext context) async {
    final height = MediaQuery.of(context).size.height / 3;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dialog test'),
          content: SizedBox(
            height: height,
            child: Content(
              isDialog: true,
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}