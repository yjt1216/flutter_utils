import 'package:flutter/material.dart';

import 'custom_zoom_in_offset.dart';

class BranchPopupModel extends StatefulWidget {
  final double left; //距离左边位置 弹窗的x轴定位
  final double top; //距离上面位置 弹窗的y轴定位
  final bool otherClose; //点击背景关闭页面
  final Widget child; //传入弹窗的样式
  final Function fun; // 把关闭的函数返回给父组件 参考vue的$emit
  final Offset offset;

  const BranchPopupModel({
    required this.child,
    this.left = 0,
    this.top = 0,
    this.otherClose = false,
    required this.fun,
    required this.offset,
  });

  @override
  _BranchPopupModelState createState() => _BranchPopupModelState();
}

class _BranchPopupModelState extends State<BranchPopupModel> {
  late AnimationController animateController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
              onTap: () async {
                if (widget.otherClose) {
                } else {
                  closePopupModel();
                }
              },
            ),
          ),
          Positioned(
            /// 这个是弹窗动画
            child: BranchZoomInOffset(
              duration: const Duration(milliseconds: 180),
              offset: widget.offset,
              controller: (controller) {
                animateController = controller;
                widget.fun(closePopupModel);
              },
              child: widget.child,
            ),
            left: widget.left,
            top: widget.top,
          ),
        ],
      ),
    );
  }

  ///关闭页面动画
  Future closePopupModel() async {
    await animateController.reverse();
    Navigator.pop(context);
  }
}
