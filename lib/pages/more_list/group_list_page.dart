import 'dart:core';

import 'package:flutter/material.dart';

import 'group_list_utils.dart';
import 'list_model.dart';

class GroupListPage extends StatefulWidget{
  const GroupListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage>{


  List<ParentBean> parentBean = [];

  int clickSectionIndex = -1;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData(){
    for(int i=0;i<10;i++){
      ParentBean parentData = ParentBean();
      parentData.index = i;
      parentData.title = "title$i";
      List<ChildBean> childBeans = [];
      for(int j=0;j<10;j++){
        ChildBean childBean = ChildBean();
        childBean.childIndex = j;
        childBean.childTitle = "childTitl$j";
        childBeans.add(childBean);
      }
      parentData.childBeans = childBeans;
      parentBean.add(parentData);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.blue,
        body: GroupListView<ParentBean>(
          data: parentBean,
          countOfItemInSection: (int parentIndex) {
            return parentBean[parentIndex].childBeans.length;
          },
          groupChildViewCreate: (parentIndex,childIndex){
            return Text(
              parentBean[parentIndex].childBeans[childIndex].childTitle!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            );
          },
          sectionViewCreate: (section){
            return GestureDetector(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  parentBean[section].title!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              onTap: (){
                parentBean[section].isOpen = !parentBean[section].isOpen;
                setState(() {

                });
              },
            );
          },
        )
    );
  }

}