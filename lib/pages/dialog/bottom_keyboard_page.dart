
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 键盘遮挡输入框
///
class BottomKeyboardPage extends StatefulWidget {
  const BottomKeyboardPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BottomKeyboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomKeyboardPage> with WidgetsBindingObserver {
  double _virtualHeight = 0;
  final double _virtualBoxBottomContentHeight = 160;
  final _sheetPadding = const EdgeInsets.all(20);

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // 此处我们用键盘高度减去虚拟框（virtualBox）下面内容的高度，在减去sheet的下方内边距。
    // 即得到虚拟框的高度
    final transDelta = MediaQuery.of(context).viewInsets.bottom - _virtualBoxBottomContentHeight - _sheetPadding.bottom;
    _virtualHeight = transDelta <= 0 ? 0 : transDelta;
    setState(() {});

    super.didChangeMetrics();
  }

  void _show() {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.25),
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
        ),
        builder: (ctx) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            padding: _sheetPadding,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                // 此处加了一个ListView，用于演示较为复杂的场景
                Expanded(child: ListView.builder(itemBuilder: (ctx, i) => Text('item_$i'), itemCount: 50)),
                Container(
                  height: 160,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.lightGreen),
                ),
                const TextField(),
                const SizedBox(height: 16),
                // 虚拟的高度，用户填充被键盘遮挡的部分
                SizedBox(height: _virtualHeight),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.teal),
                  height: _virtualBoxBottomContentHeight,
                )
              ],
            ),
          );
        });
  }

  void _showFolder() {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.25),
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top,
        ),
        builder: (ctx) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            padding: _sheetPadding,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                // 此处加了一个ListView，用于演示较为复杂的场景
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: SvgPicture.asset('assets/cloud/file_record_close.svg',width: 20,height: 20,),
                      ),
                    ),
                    Container(
                      child: const Text('新建文件夹',style: TextStyle(color: Color.fromRGBO(67, 68, 71, 1),fontSize: 18.0,fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      child:  const Text('确认',style: TextStyle(color: Color.fromRGBO(91, 87, 150, 0.5),fontSize: 14.0,fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),
               Container(
                 margin: const EdgeInsets.only(top: 64.0),
                 child:  SvgPicture.asset('assets/cloud/cloud_disk_folder.svg',width: 88,height: 88,),
               ),
                const SizedBox(height: 16.0,),
                const TextField(),
                const SizedBox(height: 16),
                // 虚拟的高度，用户填充被键盘遮挡的部分
                SizedBox(height: _virtualHeight),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  height: _virtualBoxBottomContentHeight,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: _show,
              child: const Text('显示底部弹窗'),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: _showFolder,
              child: const Text('显示新建文件-弹窗'),
            ),
          ],
        ),
      ),
    );
  }
}