import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/pages/bottom_bar/custom_bottom_bar/tab_icon_data.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'bottom_app_bar.dart';
import 'my_app_bar.dart';

/// flutter 拉面菜单
class Bottom11Page extends StatefulWidget {
  const Bottom11Page({Key? key}) : super(key: key);

  @override
  _Bottom11PageState createState() => _Bottom11PageState();
}

class _Bottom11PageState extends State<Bottom11Page> {
  int pageIndex = 0;

  /// 图标
  final List<TabIconData> iconList = TabIconData.tabIconsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: '工作台', elevation: 0),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          content(),
          bottomBar(),
        ],
      ),
    );
  }

  final List<Color> bgs = [
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.brown,
  ];

  Widget content() {
    final bg = bgs[pageIndex];

    if (pageIndex == 0){
      return _buildOnlineChannelView();
    } else if (pageIndex == 1) {
      return _buildWorkbenchView();
    } else {
      return _buildCompanyNetworkDiskView();
    }


    return AnimationLimiter(
      key: UniqueKey(),
      child: GridView.builder(
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2 + (pageIndex % 3),
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1),
        itemBuilder: (context, index) {

          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 22,
            duration: const Duration(milliseconds: 500),
            child: ScaleAnimation(child: Container(color: bg)),
          );
        },
      ),
    );

  }

  Widget bottomBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: JTCustomBottomAppBar(
        iconList: iconList,
        selectedPosition: 0,
        selectedCallback: (position) => onClickBottomBar(position),
      ),
    );
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;
    setState(() => pageIndex = index);
  }



  ///在线频道 onlineChannel
  Widget _buildOnlineChannelView() {
    return Container(
      color: Colors.orangeAccent,
    );
  }


  ///工作台W workbench
  Widget _buildWorkbenchView() {
    return Container(
      color: Colors.greenAccent,
    );
  }

  ///企业网盘 company networkDisk
  Widget _buildCompanyNetworkDiskView() {
    return Container(
      color: Colors.blueAccent,
    );
  }





}