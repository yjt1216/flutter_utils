import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaultToastDuration = Duration(seconds: 2);
const defaultToastColor = Color(0xFF424242);

class ToastUtils{



  static void toast(String msg){
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  /*static void waring(String msg, {Duration duration = defaultToastDuration}) {
    showToast(msg, duration: duration, backgroundColor: Colors.yellow);
  }

  static void error(String msg, {Duration duration = defaultToastDuration}) {

    showToast(msg, duration: duration, backgroundColor: Colors.red);
  }

  static void success(String msg,
      {Duration duration = defaultToastDuration}) {
    Fluttertoast.showToast(msg: msg);
    //showToast(msg, duration: duration, backgroundColor: Colors.lightGreen);
  }*/




}
