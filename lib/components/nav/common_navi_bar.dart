import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';

class CommonNaviBar {

  PreferredSizeWidget customNaviBar(
      {required String title,
        Color? backgroundColor,
        Color? titleColor,
        Widget? naviIcon,
        List<Map<Widget, VoidCallback>>? buttons,
        PreferredSizeWidget? tabBar}) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
            color: titleColor?? const Color.fromRGBO(67, 68, 71, 1),
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
      //iconTheme: IconThemeData(color: color_323233),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            splashRadius: 26,
            alignment: Alignment.center,
            //color: Colors.black,
            //SvgPicture.asset('assets/icons/common/nav_back_black.svg',width: 24.0,height: 24.0,)
            icon: naviIcon ?? Image.asset(Assets.naviBackBlack,width: 24.0,height: 24.0,),
            onPressed: () {
              Navigator.maybePop(context);
            },
          );
        },
      ),
      centerTitle: true,
      actions: createActions(buttons),
      bottom: tabBar,
    );
  }


  List<Widget> createActions(List<Map<Widget, VoidCallback>>? actions) {
    List<Widget> result = [];

    if (actions != null && actions.isNotEmpty) {
      actions.forEach((element) {
        Map map = element;
        Widget image = map.keys.first;
        result.add(InkWell(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(right: 20),
            child: image,
          ),
          onTap: () async {
            // bool ret = await checkNetwork();
            // if (ret) {
            //   map[image].call();
            // }
          },
        ));
      });
    }
    return result;
  }



  PreferredSizeWidget customNaviBar2(
      {required String title,
        Color? bgColor,
        ImageIcon? naviIcon,
        List<Map<Image, VoidCallback>>? buttons,
        Widget? bottom}) {
    return AppBar(
      toolbarHeight: 96.0,
      backgroundColor: bgColor ?? Colors.white,
      shadowColor: Colors.transparent,
      title: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 44.0,
            child: Stack(
              children: [
                Builder(builder: (BuildContext context) {
                  return IconButton(
                    splashRadius: 24,
                    alignment: Alignment.center,
                    icon: const ImageIcon(AssetImage('assets/images/nav_close.png'),
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  );
                }),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xFF323233),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          bottom ?? const SizedBox()
        ],
      ),
      //iconTheme: IconThemeData(color: color_323233),
      leading: const SizedBox(),
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: true,
      actions: createActions(buttons),
    );
  }



  PreferredSizeWidget customNaviBar3(
      {required String title,
        Color? backgroundColor,
        Color? titleColor,
        Widget? naviIcon,
        List<Widget>? buttons,
        PreferredSizeWidget? tabBar}) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
            color: titleColor?? const Color.fromRGBO(67, 68, 71, 1),
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
      //iconTheme: IconThemeData(color: color_323233),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            splashRadius: 26,
            alignment: Alignment.center,
            //color: Colors.black,
            icon: naviIcon ?? Image.asset(Assets.naviBackBlack,width: 24.0,height: 24.0,),
            onPressed: () {
              Navigator.maybePop(context);
            },
          );
        },
      ),
      centerTitle: true,
      actions: buttons,
      bottom: tabBar,
    );
  }







}