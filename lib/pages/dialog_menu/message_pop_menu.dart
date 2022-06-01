
import 'package:flutter/material.dart';

Color _bgColor = Colors.white;
double cellHeight = 35;
double cellWidth = 130;

typedef ClickCallBack = void Function(int selectIndex, String selectText);

class PopMenus {
  static void showPop(
      {required BuildContext context,
        required List<String> listData,
        required String selText,
        required ClickCallBack clickCallback}) {

    Widget _buildMenuLineCell(dataArr) {
      return ListView.separated(
        itemCount: dataArr.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                if (clickCallback != null) {
                  clickCallback(index, listData[index]);
                }
              },
              child: Container(
                height: cellHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    selText==dataArr[index]?
                    Text(dataArr[index], style: const TextStyle(fontSize: 16,color:
                    Colors.blue)):Text(dataArr[index], style: const TextStyle(fontSize: 16))
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0.1,
            color: Color(0xFFE6E6E6),
          );
        },
      );
    }

    _buildMenusView(dataArr) {
      double currentWidth = MediaQuery.of(context).size.width;
      var cellH = dataArr.length * cellHeight;
      var navH = 44;
      navH = 44;
      var leftP = (currentWidth-cellWidth) - 80;
      return Positioned(
        //right: leftP,
        left: leftP,
        top: navH.toDouble()+55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: TriangleUpWidget(height: 10,width: 14),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                    color: _bgColor,
                    width: cellWidth,
                    height: cellH,
                    child: _buildMenuLineCell(dataArr)))
          ],
        ),
      );
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BasePopMenus(child: _buildMenusView(listData));
        });
  }
}

class BasePopMenus extends Dialog {
  const BasePopMenus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: () => Navigator.pop(context)),
          child
        ],
      ),
    );
  }
}


class TriangleUpPainter extends CustomPainter {

  Color? color; //填充颜色
  Paint? _paint; //画笔
  Path? _path; //绘制路径
  double? angle; //角度

  TriangleUpPainter() {
    _paint = Paint()
      ..strokeWidth = 1.0 //线宽
      ..color = Colors.white
      ..isAntiAlias = true;
    _path = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final baseX = size.width;
    final baseY = size.height;
    //起点
    _path!.moveTo(baseX*0.5, 0);
    _path!.lineTo(baseX, baseY);
    _path!.lineTo(0, baseY);
    canvas.drawPath(_path!, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@immutable
class TriangleUpWidget extends StatefulWidget {
  double height;
  double width;

  TriangleUpWidget({Key? key, this.height = 14, this.width = 16}) : super(key:
  key);

  @override
  CoreTriangleState createState() => CoreTriangleState();
}

class CoreTriangleState extends State<TriangleUpWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        width: widget.width,
        child: CustomPaint(
          painter: TriangleUpPainter(),
        ));
  }
}
