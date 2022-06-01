import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:get/get.dart';

import '../../model/common_model.dart';
import '../../utils/date_utils.dart';
import '../../utils/photo/photo_view.dart';
import 'dynamic_head.dart';

class DynamicDetailPage extends StatefulWidget{
  const DynamicDetailPage({Key? key}) : super(key: key);

  @override
  _DynamicDetailPageState createState() => _DynamicDetailPageState();
}

class _DynamicDetailPageState extends State<DynamicDetailPage> {

  Map dynamicDetails = Get.arguments['dynamicItem'] ;

  //好友关系
  bool isFriendship = false;


  ScrollController mCommentScrollController = ScrollController();
  List<Comment> mCommentList = [];
  bool isCommentLoadingMore = false; //是否显示加载中
  bool isCommentHasMore = true; //是否还有更多
  int mCommentCurPage = 1;
  bool isForwardLoadingMore = false; //是否显示加载中
  bool isForwardHasMore = true; //是否还有更多
  num mForwardCurPage = 1;


  @override
  void initState()  {
    super.initState();
    print(dynamicDetails);
    _loadData();

  }
  void _loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr = await rootBundle.loadString('lib/res/dynamic_comment.json');

    Map dic = json.decode(jsonStr);
    List jsonList = dic['data'];
    jsonList.forEach((element) {
      mCommentList.add(Comment.fromJson(element));
    });

    setState(() {
      print(mCommentList.length);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: _singleScrollView2(context),
      ),
    );

  }

  //NestedScrollView
  Widget _nestScrollView(BuildContext context) {
    return Column(
      children: [
        Container(child: DynamicHeadView("微博正文"), color: Colors.white),
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                // SliverToBoxAdapter(
                //   child: Container(height: 8, color: const Color(0xffEFEFEF)),
                // ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: _dynamicTopView(context, dynamicDetails),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                      minHeight: 84.0,
                      maxHeight: 100.0,
                      child: Container(
                        color: Colors.white,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0,top: 12.0),
                                child: Text(
                                  '共20条评论',
                                  style: TextStyle(
                                      color: Color.fromRGBO(67, 68, 71, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Align(child: Text('说点什么吧~'),)

                            ],
                          ),
                        ),
                      )),
                ),
              ];
            },
            body: mCommentListWidget(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          height: 40,
          child: _detailBottom(context),
          color: const Color(0xffF9F9F9),
        )
      ],
    );
  }

  Widget _singleScrollView(BuildContext context) {

    return Column(
      children: [
        Container(child: DynamicHeadView("微博正文"), color: Colors.white),
        _dynamicTopView(context, dynamicDetails),
        Expanded(
          child: SingleChildScrollView(
            child: mCommentListWidget(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          height: 40,
          child: _detailBottom(context),
          color: const Color(0xffF9F9F9),
        ),
      ],
    );

  }


  Widget _singleScrollView2(BuildContext context) {

    return Column(
      children: [
        Container(child: DynamicHeadView("微博正文"), color: Colors.white),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _dynamicTopView(context, dynamicDetails),
                mCommentListWidget(),
              ],
            )
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          height: 40,
          child: _detailBottom(context),
          color: const Color(0xffF9F9F9),
        ),
      ],
    );

  }

  ///内容
  Widget _dynamicTopView(context, item) {
    return InkWell(
        onTap: () {
          debugPrint('_dynamicTopView');

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
                  margin: const EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('name',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
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
                                item['content'],
                              style: const TextStyle(fontSize: 13),
                            )),
                        _imagesView(context, item),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                   item['time'],
                                  style: const TextStyle(
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
  Widget _imagesView(context, item) {
    return JhNinePicture(
      imgData: item['imgs'],
      lRSpace: (80.0 + 20.0),
      onLongPress: () {
        print('objonLongPressect:');
      },
    );
  }


  ///评论列表
  Widget mCommentListWidget() {
    return mCommentList.isEmpty
        ? Container()
        : ListView.builder(
      //padding: const EdgeInsets.all(0.5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return mCommentItem(context, index, mCommentList[index]);
      },
      itemCount: mCommentList.length ,
      //controller: mCommentScrollController,
    );
  }

  //评论item
  Widget mCommentItem(BuildContext context, int index,Comment comment) {
    /*if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/weibo_comment_filter.png',
                  width: 15.0,
                  height: 17.0,
                ),
                Container(
                  child: const Text('按热度',
                      style: TextStyle(color: Color(0xff596D86), fontSize: 12)),
                  margin: const EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          )
        ],
      );
    }*/

    if (index == mCommentList.length + 1) {
      return buildCommentLoadMore();
    }

    Widget mCommentReplyWidget;
    if (comment.commentreplynum! == 0) {
      mCommentReplyWidget = Container();
    }
    else if (comment.commentreplynum! == 1) {

      mCommentReplyWidget = Container(
        padding: const EdgeInsets.only(left: 5,top: 16.0,right: 5.0,bottom: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 8.0,),
            Expanded(
              child: RichText(
                  text: TextSpan(
                      text: comment.commentreply![0].fromuName! + ": ",
                      style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                      children: <TextSpan>[
                        TextSpan(
                          text: comment.commentreply![0].content,
                          style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                        )
                      ])),
            ),

          ],
        ),

      );

    }
    else if (comment.commentreplynum! == 2) {
      mCommentReplyWidget = Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: comment.commentreply![0].fromuName! + ": ",
                            style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                            children: <TextSpan>[
                              TextSpan(
                                text: comment.commentreply![0].content,
                                style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                              )
                            ])),
                  ),

                ],
              ),
              const SizedBox(height: 16.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: comment.commentreply![0].fromuName! + ": ",
                            style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                            children: <TextSpan>[
                              TextSpan(
                                text: comment.commentreply![0].content,
                                style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                              )
                            ])),
                  ),

                ],
              ),
            ],
          )
      );
    }
    else {

      if(comment.isHasOpen){
        mCommentReplyWidget = ListView.builder(
          itemBuilder: (context, index){
            return _replyCommentItem2(comment.commentreply![index]);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comment.commentreplynum,
        );

      }else{
        mCommentReplyWidget = Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: comment.commentreply![0].fromuName! + ": ",
                            style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                            children: <TextSpan>[
                              TextSpan(
                                text: comment.commentreply![0].content,
                                style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                              )
                            ])),
                  ),

                ],
              ),
              const SizedBox(height: 16.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: comment.commentreply![0].fromuName! + ": ",
                            style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                            children: <TextSpan>[
                              TextSpan(
                                text: comment.commentreply![0].content,
                                style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                              )
                            ])),
                  ),

                ],
              ),
              InkWell(
                onTap: (){
                  debugPrint('展开余下的回复列表');
                  comment.isHasOpen = !comment.isHasOpen;
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "展开" + comment.commentreplynum.toString() + "条回复 >",
                        style:const TextStyle(color: Color.fromRGBO(45, 110, 189, 1), fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }


    }

    return Container(
      margin: const EdgeInsets.only(top: 5,left: 6,right: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/head_icon02.png',width: 40,height: 40,fit: BoxFit.cover,),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Text(comment.fromuname??'name',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: comment.fromuserismember == 0
                                      ? const Color.fromRGBO(140, 140, 140, 1)
                                      : const Color(0xffF86119)
                              )
                          )
                      ),
                    ),

                  ],
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          comment.content??'content',
                          style: const TextStyle(color: Color.fromRGBO(67, 68, 71, 1), fontSize: 13),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          //背景
                          color: Color(0xffF7F7F7),
                          //设置四周圆角 角度
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        child: mCommentReplyWidget,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DateUtil.getFormatTime2(
                            DateTime.fromMillisecondsSinceEpoch(
                                comment.createtime!))
                            .toString(),
                        style: const TextStyle(color: Color(0xff909090), fontSize: 11),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  height: 0.5,
                  color: const Color(0xffE6E4E3),
                ),

              ],
            ),
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15,left: 5),
                child: Image.asset(
                  'assets/images/icon_like.png',
                  width: 15.0,
                  height: 15.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15,left: 5),
                child: const Align(
                  child: Text('123',style: TextStyle(fontSize:12.0),),
                ),
              )
            ],
          )
        ],
      ),
    );

  }


  ///回复
  Widget _replyCommentItem(CommentReply reply) {
    return Container(
      color: Colors.red,
      margin: const EdgeInsets.only(top: 12.0,left: 5,right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/images/head_icon02.png',width: 30,height: 30,fit: BoxFit.cover,),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Text(reply.fromuName??'name',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color:  Color.fromRGBO(140, 140, 140, 1),
                              )
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              reply.content??'content',
                              style: const TextStyle(color: Color.fromRGBO(67, 68, 71, 1), fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            DateUtil.getFormatTime2(
                                DateTime.fromMillisecondsSinceEpoch(
                                    reply.createTime!))
                                .toString(),
                            style: const TextStyle(color: Color(0xff909090), fontSize: 11),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      height: 0.5,
                      color: const Color(0xffE6E4E3),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/images/icon_like.png',
              width: 15.0,
              height: 15.0,
            ),
          ),

        ],
      ),
    );
  }

  Widget _replyCommentItem2(CommentReply reply) {
    return  Container(
      padding: const EdgeInsets.only(left: 5,top: 16.0,right: 5.0,bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/head_icon02.png',width: 32,height: 32,fit: BoxFit.cover,),
          ),
          const SizedBox(width: 8.0,),
          Expanded(
            child: RichText(
                text: TextSpan(
                    text: reply.fromuName! + ": ",
                    style: const TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                    children: <TextSpan>[
                      TextSpan(
                        text: reply.content,
                        style: const TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                      )
                    ])),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/images/icon_like.png',
              width: 15.0,
              height: 15.0,
            ),
          ),
        ],
      ),

    );
  }


  ///转发收藏点赞布局
  Widget _detailBottom(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              //   return RetWeetPage(
              //     mModel: weiboItem,
              //   );
              // }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  child: const Text('转发',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                  margin: const EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 1.0,
          color: Colors.black12,
        ),
        Flexible(
          child: InkWell(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  child: const Text('评论',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                  margin: EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: 1.0,
          color: Colors.black12,
        ),
        Flexible(
          child: InkWell(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  child: const Text('点赞',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                  margin: const EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }



  Future getCommentDataLoadMore(int page, String weiboId) async {
    // FormData formData = FormData.fromMap(
    //     {"pageNum": page, "pageSize": Constant.PAGE_SIZE, "weiboid": weiboId});
    // DioManager.getInstance().post(ServiceUrl.getWeiBoDetailComment, formData,
    //         (data) {
    //       CommentList mComment = CommentList.fromJson(data['data']);
    //       setState(() {
    //         mCommentList.addAll(mComment.list);
    //         isCommentloadingMore = false;
    //         isCommenthasMore = mComment.list.length >= Constant.PAGE_SIZE;
    //       });
    //     }, (error) {
    //       setState(() {
    //         isCommentloadingMore = false;
    //         isCommenthasMore = false;
    //       });
    //     });
    print('加载更多');
  }
  //加载
  Widget buildCommentLoadMore() {
    return isCommentLoadingMore
        ? Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                  const Text("加载中..."),
                ],
              )),
        )
        : Container(
      child: isCommentHasMore
          ? Container()
          : Center(
          child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: const Text(
                "没有更多数据",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ))),
    );
  }


}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
