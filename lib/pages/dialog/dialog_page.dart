import 'package:flutter/material.dart';

class FoldA extends StatefulWidget {
  const FoldA({Key? key}) : super(key: key);

  @override
  _FoldAState createState() => _FoldAState();
}

class _FoldAState extends State<FoldA> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  List<String> sorts = [
    '默认排序',
    '首付最低',
    '月供最低',
    '车价最低',
    '车价最高'
  ];

  bool isShowShadow = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    );

    animation = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });
  }

  void ontap () {
    controller.reverse();
    isShowShadow = false;
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(137, 188, 200, 1),
          title: const Text('下拉筛选框'),
        ),
        body: Stack( //stack设置为overflow：visible之后，内部的元素中超出的部分就不能触发点击事件；所以尽量避免这种布局
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  color: Colors.yellow,
                  child: SizedBox(
                    width: 90,
                    height: 40,
                    child: Row(
                      children: const <Widget>[
                        Text('部门'),
                        Icon(Icons.keyboard_arrow_down,color: Colors.orange,)
                      ],
                    ),
                  ),
                  onPressed: () {
                    isShowShadow = true;
                    if(animation.status == AnimationStatus.completed) {
                      controller.reverse();
                    } else {
                      controller.forward();
                    }
                  },
                ),
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.green,
                  child: const Text('data'),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                isShowShadow
                    ? Expanded(
                  child: InkWell(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                        );
                      },
                    ),
                    onTap: ontap,
                  ),
                )
                    : Container(),

                Positioned(
                    top: 50,
                    child:
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      height: animation.value,
                      child: ListView(
                        children: List.generate(sorts.length, (i) {
                          return GestureDetector(
                              onTap: ontap,
                              child: Text(sorts[i])
                          );
                        }),
                      ),
                    )
                ),
              ],
            )
          ],
        )
    );
  }




  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


}