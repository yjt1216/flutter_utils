
import 'package:flutter/material.dart';
import 'package:flutter_utils/components/tab_bar/persistent_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../generated/assets.dart';
import '../../pages/home/home.dart';
import '../../pages/mine/mine.dart';
import '../../utils/doubke_tab_back_exit_app.dart';


///
///
class PersistentTabBarPage extends StatefulWidget {
  final BuildContext menuScreenContext;
  const PersistentTabBarPage({Key? key, required this.menuScreenContext}) : super(key: key);

  @override
  _PersistentBottomState createState() => _PersistentBottomState();
}
class _PersistentBottomState extends State<PersistentTabBarPage> {

  static const double _imageSize = 25.0;
  late PersistentTabController _controller;
  late bool _hideNavBar;

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const MinePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(Assets.tabbarTabCloudSelected,width: _imageSize,),
        inactiveIcon: Image.asset(Assets.tabbarTabCloud,width: _imageSize,),
        title: "首页",
        activeColorPrimary: Color(0xFF14BFD6),
        inactiveColorPrimary: const Color.fromRGBO(140, 140, 140, 1),
      ),

      PersistentBottomNavBarItem(
        icon: Image.asset(Assets.tabbarTabMineSelected,width: _imageSize,),
        inactiveIcon: Image.asset(Assets.tabbarTabMine,width: _imageSize,),
        title: ("我的"),
        activeColorPrimary: Color(0xFF14BFD6),
        inactiveColorPrimary: const Color.fromRGBO(140, 140, 140, 1),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DoubleTapBackExitApp(
        child: Scaffold(
          // appBar: AppBar(title: const Text('Navigation Bar Demo')),
          body: PersistentTabView.custom(
            context,
            controller: _controller,
            screens: _buildScreens(),
            confineInSafeArea: true,
            itemCount: 4,
            handleAndroidBackButtonPress: true,
            onWillPop: (final cxt) async{
              return false;
            },
            stateManagement: true,
            hideNavigationBar: _hideNavBar, //是否隐藏底部tab bar
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            customWidget: CustomNavBarWidget(
              items: _navBarsItems(),
              onItemSelected: (index) {
                setState(() {
                  _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
                });
              },
              selectedIndex: _controller.index,
            ),
          ),
        )
    );

  }


}