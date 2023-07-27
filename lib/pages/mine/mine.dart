import 'package:flutter/material.dart';

class MinePage extends StatefulWidget{
  const MinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }

}
class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('我的'),),
      body: const Center(
        child: Text('Mine'),
      ),
    );
  }
}