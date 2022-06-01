
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

class CustomGridPage extends StatefulWidget {
  const CustomGridPage({Key? key}) : super(key: key);

  @override
 _CustomGridState createState() => _CustomGridState();
}
class _CustomGridState extends State<CustomGridPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('CustomGridPage'),
      ),
      body: _buildGridView() ,

    );
  }

  Widget _buildView(){
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children:   [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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
          ),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return MasonryGridView.count(
      itemCount: 5,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return _testBuildView();
      },
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
                            //isAgreeProtocol = !isAgreeProtocol;
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

}