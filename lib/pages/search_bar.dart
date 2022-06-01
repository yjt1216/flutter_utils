import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key, required this.hintLabel}) : super(key: key);

  final String hintLabel;

  @override
  State<StatefulWidget> createState() {
    return SearchAppBarState();
  }
}

class SearchAppBarState extends State<SearchAppBar> {
  late FocusNode _focusNode;

  ///默认不展示控件
  bool _offstage = true;

  ///监听TextField内容变化
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController.addListener(() {
      var isVisible = _textEditingController.text.isNotEmpty;
      _updateDelIconVisible(isVisible);
    });
  }

  _updateDelIconVisible(bool isVisible) {
    setState(() {
      _offstage = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(4)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8,),
                  Image.asset(
                    "assets/images/home_search.png",
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _textEditingController,
                      // autofocus: true,
                      focusNode: _focusNode,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: widget.hintLabel,
                          hintStyle: const TextStyle(color: Color(0xFFB5B5B5)),
                          border: InputBorder.none,
                      ),
                      //decoration: InputDecoration(hintText: widget.hintLabel),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Offstage(
                    offstage: _offstage,
                    child: GestureDetector(
                      onTap: () => {_textEditingController.clear()},
                      child: Image.asset(
                        "assets/images/icon_clear.png",
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('取消 111111');
              _focusNode.unfocus();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: const Text("取消",
                  style: TextStyle(fontSize: 16, color: Color(0xFF3D7DFF))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.unfocus();
  }
}
