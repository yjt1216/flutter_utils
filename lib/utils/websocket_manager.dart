import 'dart:async';

import 'package:web_socket_channel/io.dart';

import 'dart:convert' as convert;

const String _socketApi = 'ws://121.4.189.24:8088/chatroom/api/chatroom/message';
const String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzNCIsInN1YiI6IntcImlkXCI6MzQsXCJ1c2VybmFtZVwiOlwicXdlMTIzNDU2XCJ9IiwiaWF0IjoxNjUxODI0NjcwLCJleHAiOjE2NTI2ODg2NzB9.5eah5BdqUdTCTjc49fak9UeC-BispgpeXViyliGZh_g';


const String _socketPersonalApi = 'ws://121.4.189.24:8088/chatroom/api/personalWebServer';//ws://121.4.189.24:8088/chatroom/api/personalWebServer

class SocketUtils {
  SocketUtils._internal();
  static final SocketUtils _socketUtils = SocketUtils._internal();
  IOWebSocketChannel? _channel;
  Timer? _timer;

  factory SocketUtils() {
    return _socketUtils;
  }

  void initSocket() {
    // _channel = IOWebSocketChannel.connect(Uri.parse(_socketApi));
    _channel = IOWebSocketChannel.connect(_socketPersonalApi);

    print(Uri.parse(_socketPersonalApi));
    Map<String, dynamic> params = <String, dynamic>{};
    //params["userId"] = SpUtils().getUserInfo().appUserDetailsVO.drvId;
    //params["userName"] = SpUtils().getUserInfo().appUserDetailsVO.drvName;
    params["access_token"] = accessToken;
    // params["channel"] = 'Personal';
    // params["oId"] = 12;
    // params["type"] = 'CHAT';
    // params["uId"] = 28;
    // params["msg"] = '';

    // 发送数据到服务端
    // socket.emit('toServer',{
    //   "channel": "Personal",
    //   "msg": "{\"sender\":\"28\",\"receiver\":\"31\",\"type\":\"CHAT\",\"channel\":\"Company\",\"message\":\"测试消息收到没1111\",\"date\":\"2022-05-10\",\"time\":\"10:51:37\",\"title\":\"TylerMao\",\"avatarUrl\":\"03294aa298564b71b963bed42be6d7c2.jpg\"}",
    //   "oId": 12,
    //   "type": "CHAT",
    //   "uId": 28,
    // });




    _channel?.sink.add(convert.jsonEncode(params));
    _channel?.stream.listen(onData, onError: onError, onDone: onDone);
    startCountdownTimer();
  }

  ///开启心跳
  void startCountdownTimer() {
    const oneSec = Duration(seconds: 30);
    var callback = (timer) {
      if (_channel == null) {
        initSocket();
      } else {
       // dispose();
        // if(SpUtils().getUserInfo() != null){
        //   _channel.sink
        //       .add("10002${SpUtils().getUserInfo().appUserDetailsVO.drvId}");
        // }
      }
    };
    _timer = Timer.periodic(oneSec, callback);
  }

  onDone() {
    print("消息关闭");
    if (_channel != null) {
      _channel?.sink.close();
      _channel = null;
    }
  }

  onError(err) {
    print("消息错误 --- $err");
    if (_channel != null) {
      _channel?.sink.close();
      _channel = null;
    }
  }

  onData(event) {
    try {
      if (event != null) {
        switch (event) {
          case "10001"://服务器回应正常
          case "10002":
            break;
          case "10005":
            dispose();
            //EventBusUtil.getInstance()
            //   .fire(PageEvent(eventType: EventBusUtil.UNAUTHORIZED, data: "已在其他设备上登录\n请重新登录"));
            break;
          default:
            event = convert.jsonDecode(event);
            switch (event["msgtype"]) {//消息类型
              case 10006:
              //新的通知消息
                //EventBusUtil.getInstance().fire(
                //    PageEvent(eventType: EventBusUtil.NEWMESSAGE));
                break;

              case 20012:
              //通知刷新列表
                //EventBusUtil.getInstance()
                //    .fire(PageEvent(eventType: EventBusUtil.REFRESHORDERLIST));
                break;
              case 20014:
              ///有新订单
                //EventBusUtil.getInstance()
                //    .fire(PageEvent(eventType: EventBusUtil.NEWORDERMESSAGE));
                break;
            }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    if (_channel != null) {
      _channel?.sink.close();
      print("socket通道关闭");
      _channel = null;
    }
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }
}


