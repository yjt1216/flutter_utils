import 'package:flutter/material.dart';

import 'list_model.dart';

typedef GroupChildViewCreate = Widget Function(int parentIndex,int childIndex);
typedef SectionViewCreate = Widget Function(int index);

class TwoLevelWidget<T extends BaseBean> extends StatefulWidget{

  final GroupChildViewCreate groupChildViewCreate;
  final SectionViewCreate sectionViewCreate;
  final T data;
  TwoLevelWidget(
      this.groupChildViewCreate,
      this.sectionViewCreate,
      this.data,
      );

  @override
  State<StatefulWidget> createState() =>  _TwoLevelWidgetState();

}

class _TwoLevelWidgetState extends State<TwoLevelWidget>{

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: widget.sectionViewCreate(widget.data.index),
        ),
        widget.data.isOpen ? Padding(
            padding: const EdgeInsets.only(left: 30),
            child:  ListView.builder(
              itemBuilder: (context,index){
                return widget.groupChildViewCreate(widget.data.index,index);
              },
              itemCount: widget.data.getChildSize(),
              shrinkWrap: true,/*内嵌listView 这个值要设置成true*/
              primary: true,
              physics: NeverScrollableScrollPhysics(), /*嵌套滑动这个也得限制 不然 滑动子列表 外层不滚动*/
            )
        ) : Container()
      ],
    );

  }

}