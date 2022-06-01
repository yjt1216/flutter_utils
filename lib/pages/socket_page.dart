
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

const String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzNCIsInN1YiI6IntcImlkXCI6MzQsXCJ1c2VybmFtZVwiOlwicXdlMTIzNDU2XCJ9IiwiaWF0IjoxNjUxODI0NjcwLCJleHAiOjE2NTI2ODg2NzB9.5eah5BdqUdTCTjc49fak9UeC-BispgpeXViyliGZh_g';

class SocketPage extends StatefulWidget {
  const SocketPage({Key? key}) : super(key: key);
  @override
  _SocketPageState createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {

  final ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  List messageList = [];

  String socketUrl = "ws://121.4.189.24:8088/chatroom/api/chatroom/message";
  final String _socketPersonalApi = 'ws://121.4.189.24:8088/chatroom/api/personalWebServer';//ws://121.4.189.24:8088/chatroom/api/personalWebServer

  @override
  void initState() {
    super.initState();

    socket = IO
        .io(
        _socketPersonalApi,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'access_token': accessToken})
            //.setPath("/chatroom/api/chatroom/message")
            //.setQuery({"room_id": "", "room_type": "lobby"}) // optional
            .build());

    // 连接事件
    socket.on('connect', (_) {
      print('connect..');
    });
    // 接受来自服务端的数据
    socket.on('toClient', (data){
      debugPrint(data);
      setState(() {
        messageList.add(data);
      });
      // 改变滚动条的位置
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent+80);

    });
    // 断开连接
    socket.on('disconnect', (_){
      print('disconnect');
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Socket.io演示"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){

          socket.emit('message',{
              "channel": "Personal",
              "msg": "{\"sender\":\"28\",\"receiver\":\"31\",\"type\":\"CHAT\",\"channel\":\"Personal\",\"message\":\"测试消息收到没1111\",\"date\":\"2022-05-10\",\"time\":\"10:51:37\",\"title\":\"TylerMao\",\"avatarUrl\":\"03294aa298564b71b963bed42be6d7c2.jpg\"}",
              "oId": 12,
              "type": "CHAT",
              "uId": 28,
          });

          // 发送数据到服务端
          // socket.emit('toServer',{
          //   "channel": "Personal",
          //   "msg": "{\"sender\":\"28\",\"receiver\":\"31\",\"type\":\"CHAT\",\"channel\":\"Company\",\"message\":\"测试消息收到没1111\",\"date\":\"2022-05-10\",\"time\":\"10:51:37\",\"title\":\"TylerMao\",\"avatarUrl\":\"03294aa298564b71b963bed42be6d7c2.jpg\"}",
          //   "oId": 12,
          //   "type": "CHAT",
          //   "uId": 28,
          // });

        },
      ),
      body: ListView.builder(
        // 滚动控制器
        controller: _scrollController,
        itemCount: messageList.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text("${messageList[index]}"),
          );
        },
      ),
    );
  }
}