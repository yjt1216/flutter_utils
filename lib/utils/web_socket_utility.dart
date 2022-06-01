/// # ClassName: web_socket_utility
/// * Author: maojiu
/// * Date:2021/9/14 11:34 上午
/// * Email:lovemaojiu@gmail.com
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/utils/toast_util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// WebSocket地址
const String _socketApi = 'ws://121.4.189.24:8088/chatroom/api/chatroom/message';

const String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzNCIsInN1YiI6IntcImlkXCI6MzQsXCJ1c2VybmFtZVwiOlwicXdlMTIzNDU2XCJ9IiwiaWF0IjoxNjUxODI0NjcwLCJleHAiOjE2NTI2ODg2NzB9.5eah5BdqUdTCTjc49fak9UeC-BispgpeXViyliGZh_g';

/// WebSocket状态
enum SocketStatus {
  socketStatusConnected, // 已连接
  socketStatusFailed, // 失败
  socketStatusClosed, // 连接关闭
}

class WebSocketUtility {
  /// 单例对象
  static WebSocketUtility? _socket;

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  WebSocketUtility._();

  /// 获取单例内部方法
  factory WebSocketUtility() {
    // 只能有一个实例
    _socket ??= WebSocketUtility._();
    return _socket!;
  }

  IOWebSocketChannel? _webSocket; // WebSocket
  late SocketStatus socketStatus; // socket状态
  Timer? _heartBeat; // 心跳定时器
  late final int _heartTimes = 15000; // 心跳间隔(毫秒)
  late final num _reconnectCount = 60; // 重连次数，默认60次
  late num _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; // 重连定时器
  late Function onError; // 连接错误回调
  late Function onOpen; // 连接开启回调
  late Function onMessage; // 接收消息回调

  /// 初始化WebSocket
  void initWebSocket(
      {Function? onOpen, Function? onMessage, Function? onError}) {
    this.onOpen = onOpen!;
    this.onMessage = onMessage!;
    this.onError = onError!;
    _openSocket();
  }

  /// 开启WebSocket连接
  void _openSocket() {
    closeSocket();
    _webSocket = IOWebSocketChannel.connect(
      _socketApi,
      headers: {
        "access_token":accessToken
      },
    );

    debugPrint('WebSocket连接成功: $_socketApi');
    // 连接成功，返回WebSocket实例
    socketStatus = SocketStatus.socketStatusConnected;
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
    onOpen();
    // 接收消息
    _webSocket!.stream.listen((data) => _webSocketOnMessage(data),
        onError: _webSocketOnError, onDone: _webSocketOnDone);
  }

  /// WebSocket接收消息回调
  _webSocketOnMessage(data) {
    onMessage(data);
  }

  /// WebSocket关闭连接回调
  _webSocketOnDone() {
    print('closed');
    _reconnect();
  }

  /// WebSocket连接错误回调
  _webSocketOnError(e) {
    WebSocketChannelException ex = e;
    socketStatus = SocketStatus.socketStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  /// 初始化心跳
  void initHeartBeat() {
    _destroyHeartBeat();
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      _sentHeart();
    });
  }

  /// 心跳
  void _sentHeart() {
    sendMessage('{"action": "HEART_CHECK", "message": "请求心跳"}');
  }

  /// 销毁心跳
  void _destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
    if (_reconnectTimer != null) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
  }

  /// 关闭WebSocket
  void closeSocket() {
    if (_webSocket != null) {
      debugPrint('WebSocket连接关闭');
      _webSocket!.sink.close();
      _destroyHeartBeat();
      socketStatus = SocketStatus.socketStatusClosed;
    }
  }

  /// 发送WebSocket消息
  void sendMessage(message) {
    if (_webSocket != null) {
      switch (socketStatus) {
        case SocketStatus.socketStatusConnected:
          debugPrint('发送中：' + message);
          _webSocket!.sink.add(message);
          break;
        case SocketStatus.socketStatusClosed:
          debugPrint('连接已关闭');
          ToastUtils.toast('连接已关闭！');
          break;
        case SocketStatus.socketStatusFailed:
          debugPrint('发送失败');
          ToastUtils.toast('Socket连接出错');
          break;
        default:
          break;
      }
    }
  }

  /// 重连机制
  void _reconnect() {
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer =
          Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        _openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        debugPrint('重连次数超过最大次数');
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      }
      return;
    }
  }
}
