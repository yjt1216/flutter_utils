
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:get/get.dart';
import '../../utils/photo/photo_view.dart';
import 'dynamic_detail_page.dart';

///朋友圈
///
class WxFriendsCirclePage extends StatefulWidget {
  const WxFriendsCirclePage({Key? key}) : super(key: key);

  @override
  _WxFriendsCirclePageState createState() => _WxFriendsCirclePageState();
}

class _WxFriendsCirclePageState extends State<WxFriendsCirclePage> {
  final ScrollController _scrollController = ScrollController();

  late  var _dataArr = [];

  String testText = '不要将希望寄托于未来，寄托于那些不确定的东西。好好把握现在，把握生命里最灿烂的年华与青春，该来的来，该走的由他走，无论你有多么的不舍、不愿意，一个人决心要离开你，你始终是想拦也拦不住的。';


  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr = await rootBundle.loadString('lib/res/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    // dataArr.forEach((item) {
    // });
    _dataArr = dataArr;
    setState(() {});
  }


  @override
  void dispose() {
    //为了避免内存泄露，_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context, _dataArr),
    );
  }

  Widget _body(context, dataArr) {
    return Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 44.0),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length ,
              itemBuilder: (BuildContext context, int index) {
                // if (index == 0) {
                //   return SizedBox(
                //     width: double.infinity,
                //     height: _imgNormalHeight,
                //   );
                // }
                return _cell(context, dataArr[index]);
              }),
        ),
      ),
      // Positioned(
      //   top: 0,
      //   left: 0,
      //   right: 0,
      //   height: _imgChangeHeight,
      //   child: _header(context),
      // ),
    ]);
  }

  //cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () {
          debugPrint('cell');
          Get.to(() => const DynamicDetailPage(),arguments: {
            'dynamicItem': item,
          });
        },
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFFE6E6E6)), //下边框
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //头像
              InkWell(
                onTap: () {
                  debugPrint('头像');
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/head_icon02.png',width: 40,height: 40,fit: BoxFit.cover,),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: const Text(
                            'name',
                            style: TextStyle(
                                color: Color(0xFF586D98), fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                            child: Text(
                              testText,
                              style: const TextStyle(fontSize: 13),
                            )),
                        _imgs(context, item),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '2022-12-12',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 13),
                                ),
                                InkWell(
                                  child: Container(
                                    width: 34,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(240, 240, 240, 1),
                                    ),
                                    child: Image.asset(
                                      'assets/wechat/discover/ic_diandian.png',
                                      color: const Color(0xFF586D98),
                                    ),
                                  ),
                                  onTap: () {
                                    debugPrint('评论');
                                  },
                                )
                              ],
                            )),
                      ])),
            ],
          ),
        ));
  }

  //图片view
  Widget _imgs(context, item) {
    return JhNinePicture(
      imgData: item['imgs'],
      lRSpace: (80.0 + 20.0),
      onLongPress: () {
        print('objonLongPressect:');
        },
    );
  }


}
