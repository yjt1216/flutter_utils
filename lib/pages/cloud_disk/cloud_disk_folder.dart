
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/toast_util.dart';

class CloudDiskFolder extends StatefulWidget {
  const CloudDiskFolder({Key? key}) : super(key: key);

  @override
  _CloudDiskFolderState createState() => _CloudDiskFolderState();
}
class _CloudDiskFolderState extends State<CloudDiskFolder> {

  List folderList = ['1','2','3'];

  bool isAgreeProtocol = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100,),
          folderGridWidget(context),
          const SizedBox(height: 30,),

          _testBuildView(),
        ],
      ),
    );
  }

  Widget _testBuildView() {
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10,),
      decoration:  BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          color: const Color.fromRGBO(244, 244, 244, 1),
        ),
      ),
      height: 166,width: 164,
     child: Column(
       children: [
         Container(
           color: Colors.red,
           height: 96,
           child:  Container(
             //margin: const EdgeInsets.only(left: 56,right: 56,top: 24,bottom: 24),
             color: const Color.fromRGBO(255, 255, 255, 1),
             child: Align(
               child: SvgPicture.asset('assets/cloud/cloud_disk_folder.svg',width: 44,height: 44,),
             ),
           ),
         ),
         Container(
           color: const Color.fromRGBO(244, 244, 244, 1),
           height: 68,
           child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Row(
                 children: [
                   Container(
                     margin: const EdgeInsets.only(top: 12,left: 12),
                     child: const Text(
                       '工作文件夹',
                       style: TextStyle(color: Color.fromRGBO(67, 68, 71, 1),fontSize: 14.0,fontWeight: FontWeight.w500),
                       overflow: TextOverflow.ellipsis,
                     ),
                   ),
                   const Spacer(),
                   Container(
                     margin: const EdgeInsets.only(top: 12.0),
                     child: InkWell(
                       onTap: (){
                         setState(() {
                           isAgreeProtocol = !isAgreeProtocol;
                         });
                       },
                       child: SvgPicture.asset('assets/cloud/check_circle_selected.svg',width: 16,height: 16,) ,
                     ),
                   ),
                   const SizedBox(width: 5.0,),
                 ],
               ),
               Container(
                 margin: const EdgeInsets.only(top: 12,left: 12.0,bottom: 12),
                 child: const Text(
                   '2022-05-04 13:45',
                   style: TextStyle(color: Color.fromRGBO(140, 140, 140, 1),fontSize: 10.0,fontWeight: FontWeight.normal),
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
             ],
           ),
         )
       ],
     ),
    );
  }


  Widget folderGridWidget(BuildContext context) {
    return  GridView.builder(
      padding: const EdgeInsets.only(left: 16,right: 16),
      itemCount: 4,
      shrinkWrap: true,
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //横轴
        crossAxisSpacing: 8,
        mainAxisSpacing: 20,
        childAspectRatio: 166/164,
      ),
      itemBuilder: (context, index) {
        // return _folderGridItem(context, index);
        return _testBuildView();
      },
    );
  }

  Widget _folderGridItem(BuildContext context, int index) {
    return InkWell(
      onTap: (){
        ToastUtils.toast('工作文件夹');
      },
      child: Container(
        decoration:  BoxDecoration(
          color: const Color.fromRGBO(255, 11, 255, 1),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
            color: const Color.fromRGBO(244, 244, 244, 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 56,right: 56,top: 24,bottom: 24),
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Align(
                child: SvgPicture.asset('assets/cloud/cloud_disk_folder.svg',width: 44,height: 44,),
              ),
            ),
            Container(
              margin: EdgeInsets.zero,
              color: const Color.fromRGBO(244, 244, 244, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12,left: 12),
                        child: const Text(
                          '工作文件夹',
                          style: TextStyle(color: Color.fromRGBO(67, 68, 71, 1),fontSize: 14.0,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(top: 12.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              isAgreeProtocol = !isAgreeProtocol;
                            });
                          },
                          child: SvgPicture.asset('assets/cloud/check_circle_selected.svg',width: 16,height: 16,) ,
                        ),
                      ),
                      const SizedBox(width: 5.0,),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12,left: 12.0,bottom: 12),
                    child: const Text(
                      '2022-05-04 13:45',
                      style: TextStyle(color: Color.fromRGBO(140, 140, 140, 1),fontSize: 10.0,fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

}