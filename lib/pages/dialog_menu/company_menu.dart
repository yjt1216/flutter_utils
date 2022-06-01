
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/common_navi_bar.dart';
import '../bottom_bar/custom_bottom_bar/bottom_app_bar.dart';
import '../bottom_bar/custom_bottom_bar/tab_icon_data.dart';
import 'company_online_page.dart';
import 'company_popup.dart';
import 'custom_menu_model.dart';
import 'message_pop_menu.dart';

/// 办公
class CompanyBranchPage extends StatefulWidget {
  const CompanyBranchPage({Key? key}) : super(key: key);

  @override
  _CompanyBranchPageState createState() => _CompanyBranchPageState();
}

class _CompanyBranchPageState extends State<CompanyBranchPage> {
  int pageIndex = 0;

  /// 图标
  final List<TabIconData> iconList = TabIconData.tabIconsList;

  List<String> dataList = [
    '语文','数学','物理','生物','化学',
  ];


  /// 测试弹框
  GlobalKey dialogKey = GlobalKey();
  late Size dialogSize;
  late Offset dialogOffset;

  @override
  void initState() {
    super.initState();

    debugPrint('WidgetsBinding.instance ${WidgetsBinding.instance}');
    debugPrint('dialogKey $dialogKey');
    debugPrint('dialogKey ${dialogKey.currentContext}');
    debugPrint('dialogKey ${dialogKey.currentWidget}');


    ///等待widget初始化完成
    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      ///通过key获取到widget的位置
      RenderBox box = dialogKey.currentContext!.findRenderObject() as RenderBox;
      ///获取widget的高宽
      dialogSize = box.size;
      ///获取位置
      dialogOffset = box.localToGlobal(Offset.zero);
    });


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CommonNaviBar().customNaviBar(
        title: '铭阳互联网科技有限公司',
        backgroundColor: const Color.fromRGBO(91, 87, 150, 1),
        titleColor: Colors.white,
        naviIcon: SvgPicture.asset('assets/cloud/nav_back_white.svg',width: 22.0,height: 18.0,),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          content(context),
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

  Widget content(BuildContext context) {

    if (pageIndex == 0){
      return const CompanyOnlinePage();
      // return _buildOnlineChannelView();
    } else if (pageIndex == 1) {
      return _buildWorkbenchView();
    } else {
      return _buildCompanyNetworkDiskView(context);
    }

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


  void showDialogModel(BuildContext context) {
    /// 设置弹窗的高宽
    double _dialogWidth = MediaQuery.of(context).size.width;
    double _dialogHeight =  MediaQuery.of(context).size.height;


    Navigator.push(
      context,
      BranchPopup(
        child: BranchPopupModel(
          left: 0,
          top: 150,
          offset: Offset(_dialogWidth / 2, -_dialogHeight / 2),
          child: SizedBox(
            width: _dialogWidth,
            height: _dialogHeight/2,
            child: Container(
              color: Colors.yellowAccent,
            ),
          ),
          fun: (close) {

          },
        ),
      ),
    );
  }


  ///工作台W workbench
  Widget _buildWorkbenchView() {
    return Container(
      color: Colors.greenAccent,
    );
  }

  ///企业网盘 company networkDisk

  Widget _buildCompanyNetworkDiskView(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  showDialogModel(context);
                },
                key: dialogKey,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16.0,top: 20.0,right: 4.0,bottom: 20.0),
                      child: const Text('部门',style: TextStyle(color: Color.fromRGBO(67, 68, 71, 1),fontWeight: FontWeight.w500,fontSize: 16.0),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 22.0,bottom: 20.0),
                      child: SvgPicture.asset('assets/cloud/company_caret_down.svg',width: 12,height: 12,),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  PopMenus.showPop(
                      context: context,
                      listData: dataList,
                      selText: 'selText',
                      clickCallback: (index,string){
                        debugPrint(string);
                      }
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0,top: 22.0,bottom: 20.0),
                  child: SvgPicture.asset('assets/cloud/cloud_reload_time.svg',width: 22.0,height: 22.0,),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0,top: 22.0,bottom: 20.0),
                  child: SvgPicture.asset('assets/cloud/cloud_swap.svg',width: 22.0,height: 22.0,),
                ),
              ),
              InkWell(
                onTap: (){
                  SmartDialog.show(
                    alignment: Alignment.bottomCenter,
                    builder: (_){
                      return Container(
                        color: Colors.cyan,
                        width: double.infinity,
                        height: 92,
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20.0,top: 22.0,bottom: 20.0),
                  child: SvgPicture.asset('assets/cloud/cloud_edit_square.svg',width: 22.0,height: 22.0,),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }






}