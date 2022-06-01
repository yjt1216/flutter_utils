import 'package:flutter/material.dart';

//微博详情头部标题布局
class DynamicHeadView extends StatefulWidget {
  String mTitle;

  DynamicHeadView(this.mTitle, {Key? key}) : super(key: key);

  @override
  _DynamicHeadViewState createState() => _DynamicHeadViewState();
}

class _DynamicHeadViewState extends State<DynamicHeadView> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 50,
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.mTitle,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTapDown: _handleTapDown,
                          // Handle the tap events in the order that
                          onTapUp: _handleTapUp,
                          // they occur: down, up, tap, cancel
                          onTap: () {
                            //  Navigator.pop(context);
                          },
                          onTapCancel: _handleTapCancel,
                          child: Image.asset(
                            'assets/images/icon_more.png',
                            width: 23.0,
                            height: 23.0,
                          ),
                      )
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTapDown: _handleTapDown,
                          // Handle the tap events in the order that
                          onTapUp: _handleTapUp,
                          // they occur: down, up, tap, cancel
                          onTap: () {
                            Navigator.pop(context);
                          },
                          onTapCancel: _handleTapCancel,
                          child: _highlight
                              ? Image.asset(
                                'assets/images/icon_back_highlighted.png',
                            width: 23.0,
                            height: 23.0,
                          )
                              : Image.asset(
                            'assets/images/icon_back.png',
                            width: 23.0,
                            height: 23.0,
                          ))),
                ],
              ),
            ),
            color: Colors.white),
        Container(
          color: Colors.red,
          height: 0.5,
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

}
