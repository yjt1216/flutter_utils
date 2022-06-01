import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({Key? key}) : super(key: key);

  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {

  var status = true;
  var flag = true;
  var check = true;

  List<bool> selectedList = [false,false,false,false];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text("多选框"),
        ),
        body: _buildGroupView()
    );
  }

  Widget _buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[
        Row(
          children:<Widget>[
            // 选中框
            Checkbox(
              value:status,
              // 改变后的事件
              onChanged:(value){
                setState(() {
                  status = value!;
                });
              },
              // 选中后的颜色
              activeColor: Colors.red,
              // 选中后对号的颜色
              checkColor: Colors.blue,
            ),
            Text(status?"选中":"取消")
          ],
        ),

        const SizedBox(height:10),
        // 带标题的选中框
        CheckboxListTile(
          value:flag,
          // 改变后的事件
          onChanged:(value){
            setState(() {
              flag = value!;
            });
          },
          title:const Text("标题"),
          //subtitle: const Text("这是副标题"),
          // 选中后的颜色
          activeColor: Colors.blue,
          // 选中的文字是否跟着高亮
          selected: flag,
          // 选中后对号的颜色
          checkColor: Colors.grey,
        ),

        const SizedBox(height:10),
        // 带图标和标题的选中框
        CheckboxListTile(
          value:check,
          onChanged:(value){
            setState(() {
              check = value!;
            });
          },
          title:const Text("标题"),
          subtitle: const Text("这是副标题"),
          secondary: const Icon(Icons.help),
          activeColor: Colors.red,
          selected: check,
          checkColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: selectedList.length,
        itemBuilder: (BuildContext context, int index){
          return CheckboxListTile(
            title: Text("标题$index"),
            value: selectedList[index],
              onChanged: (value){
                setState(() {
                  selectedList[index] = value!;
                });
              },
            activeColor: Colors.blue,
            checkColor: Colors.grey,
          );
        }
    );
  }

  Widget _chatFriendItem(String title,int index) {
    return Row(
      children: [
        Checkbox(
          value:selectedList[index],
          // 改变后的事件
          onChanged:(value){
            setState(() {
              selectedList[index] = value!;
            });
          },
          // 选中后的颜色
          activeColor: Colors.red,
          // 选中后对号的颜色
          checkColor: Colors.blue,
        ),
        Text(title, style: const TextStyle(fontSize: 18.0,color: Colors.black),)
      ],
    );
  }

  Widget _buildGroupView() {
    return ListView.builder(
        itemCount: selectedList.length,
        itemBuilder: (BuildContext context, int index){
          return _chatFriendItem('title$index', index);
        }
    );
  }


}