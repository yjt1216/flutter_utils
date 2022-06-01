
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';


class SheetPage extends StatefulWidget{

  @override
  _SheetPageState createState() => _SheetPageState();
}
class _SheetPageState extends State<SheetPage> {

  
  List<String> friendList = ['tom','lili','lucy'];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        //child: _clickView(context),
        child: _checkListView(context, friendList),
      ),
    );
  }


  /// 底部弹框
  Future<T?> showSheet<T>(
      BuildContext context,
      Widget body, {
        bool scrollControlled = false,
        Color bodyColor = Colors.white,
        EdgeInsets? bodyPadding,
        BorderRadius? borderRadius,
      }) {
    const radius = Radius.circular(16);
    borderRadius ??= const BorderRadius.only(topLeft: radius, topRight: radius);
    bodyPadding ??= const EdgeInsets.all(20);
    return showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: bodyColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        barrierColor: Colors.black.withOpacity(0.25),
        // A处
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top),
        isScrollControlled: scrollControlled,
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(
            left: bodyPadding!.left,
            top: bodyPadding.top,
            right: bodyPadding.right,
            // B处
            bottom: bodyPadding.bottom + MediaQuery.of(ctx).viewPadding.bottom,
          ),
          child: body,
        ));
  }


  Widget _clickView(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 64.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/mine_info_phone.png',height: 20,width: 20,),
                          const Text('语音通话',style: TextStyle(fontSize: 18.0,color: Colors.black),),
                        ],
                      ),
                    ),
                    Divider(indent: 15,endIndent:15.0,height: 1.5,color: HexColor('#EEEEEE'),),
                    SizedBox(
                      height: 64.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/mine_info_video.png',height: 20,width: 20,),
                          const Text('视频通话',style: TextStyle(fontSize: 18.0,color: Colors.black),),
                        ],
                      ),
                    ),
                    const Divider(height: 1.5,color: Colors.grey,),
                    SizedBox(
                      height: 64.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text('取消',style: TextStyle(fontSize: 18.0,color: Colors.black),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      },
      child: const Text('Click'),
    );

  }


  Widget _checkListView(BuildContext context, List<String> options) {
    Set<int> selected = <int>{};
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      height: MediaQuery.of(context).size.height / 2.0,
      child: Column(
          children: [
            const Divider(height: 1.0),
            Expanded(
              child: ListView.builder(

                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: Icon(
                        selected.contains(index)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColor),
                    title: Text(options[index]),
                    onTap: () {
                      setState(() {
                        if (selected.contains(index)) {
                          selected.remove(index);
                        } else {
                          selected.add(index);
                        }
                      }
                  );
                },
              );
            },
            itemCount: options.length,
          ),
        ),
      ]),
    );
  }

  Widget _getModalSheetHeaderWithConfirm(String title,
      {required Function onCancel, required Function onConfirm}) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onCancel();
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: () {
                onConfirm();
              }),
        ],
      ),
    );
  }
  
  


}




