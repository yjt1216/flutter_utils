import 'package:flutter/material.dart';
import 'package:flutter_utils/pages/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,  //清除title左右padding，默认情况下会有一定的padding距离
        toolbarHeight: 44, //将高度定到44，设计稿的高度。为了方便适配，
        backgroundColor: Colors.white,
        elevation: 0,
        //由于title本身是接受一个widget，所以可以直接给他一个自定义的widget。
        /*title: DecoratedBox(
          child: const SearchAppBar(
            hintLabel: "电影/电视剧/影人",
          ),
          decoration: BoxDecoration(
            color: const Color(0xfff1f1f3),
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),*/
        title: const SearchAppBar(
          hintLabel: "电影/电视剧/影人",
        ),

      ),
      body: Container(),
    );

  }

  Widget itemBuilder(BuildContext context, int index) {
    return Text("Column$index");
  }
}

