import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // 给列表滚动添加监听
    scrollController.addListener(() {
      // 滑动到底部的判断
      if (!isLoading &&
          scrollController.position.pixels >= scrollController.position.maxScrollExtent
      ) {
        // 开始加载数据
        setState(() {
          isLoading = true;
          loadMoreData();//加载数据
        });
      }
    });
  }
  @override
  void dispose() {
    // 组件销毁时，释放资源
    super.dispose();
    scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('监听滑动'),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
            controller: scrollController,//监听滑动
            itemCount: listCount + 1,//这里多了一行"加载更多"组件
            itemBuilder: (context, index) {
              if (index < listCount) {
                return Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text("卜大爷 $index"),
                      subtitle: const Text("010-12345678"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    ));
              } else {
                return renderBottom();
              }
            }),
      ),
    );
  }

  int listCount = 10;//当前列表显示的子item数量
  Future loadMoreData() {//上拉加载更多，加载数据处理
    return Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        listCount += 10;
      });
    });
  }
  Future onRefresh() {//下拉刷新
    return Future.delayed(const Duration(seconds: 1), () {
      print('当前已是最新数据');
      setState(() {
        //这里刷新列表数据
        listCount = 10;
      });
    });
  }
  Widget renderBottom() {
    if(isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '努力加载中...',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF111111),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: const Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF111111),
          ),
        ),
      );
    }
  }
}
