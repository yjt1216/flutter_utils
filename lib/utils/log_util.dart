import 'package:logger/logger.dart';

const String _tag = "cloud_family";

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

logV(String msg) {
  _logger.v("$_tag :: $msg");
}

logD(String msg) {
  _logger.d("$_tag :: $msg");
}

logI(String msg) {
  _logger.i("$_tag :: $msg");
}

logW(String msg) {
  _logger.w("$_tag :: $msg");
}

logE(String msg) {
  _logger.e("$_tag :: $msg");
}

logWTF(String msg) {
  _logger.wtf("$_tag :: $msg");
}

// 可以在utils定义log.dart
void printLog(Object message, StackTrace current) {
  MYCustomTrace programInfo = MYCustomTrace(current);
  logI("文件: ${programInfo.fileName}, 行: ${programInfo.lineNumber}, 打印信息: $message");
}

class MYCustomTrace {
  final StackTrace _trace;
  String fileName = "";
  int lineNumber = 0;
  int columnNumber = 0;

  MYCustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    fileName = listOfInfos[0];
    lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);
  }

}

