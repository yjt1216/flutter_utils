import 'dart:math';

import 'log_config.dart';
import 'log_manager.dart';
import 'log_print.dart';
import 'log_type.dart';


///格式化的接口类
abstract class ILogFormatter<T> {
  String format(T data);
}


///堆栈裁切工具类
class StackTraceUtil {
  ///正则表达式 表示#+数字+空格的格式
  static final RegExp _startStr = RegExp(r'#\d+[\s]+');

  ///正则表达式表示 多个非换行符+ (非空) 正则表达式中()代表子项 如果需要正则()需要转义\( \)
  ///了解更多 https://www.runoob.com/regexp/regexp-syntax.html
  static final RegExp _stackReg = RegExp(r'.+ \(([^\s]+)\)');

  /// 把StackTrace 转成list 并去除无用信息
  /// [stackTrace] 堆栈信息
  ///#0      LogUtil._logPrint (package:com.halfcity.full_flutter_app/utils/log/log_util.dart:104:42)
  static List<String> _fixStack(StackTrace stackTrace) {
    List tempList = stackTrace.toString().split("\n");
    List<String> stackList = [];
    for (String str in tempList) {
      if (str.startsWith(_startStr)) {
        //又是#号又是空格比较占地方 这里省去了 如果你不想省去直接传入str即可
        stackList.add(str.replaceFirst(_startStr, ' '));
      }
    }
    return stackList;
  }

  ///获取剔除忽略包名及其其他无效信息的堆栈
  /// [stackTrace] 堆栈
  /// [ignorePackage] 需要忽略的包名
  static List<String> _getRealStackTrack(
      StackTrace stackTrace, String ignorePackage) {
    ///由于Flutter 上的StackTrack上的不太一样,Android返回的是list flutter返回的是StackTrack 所以需要手动切割 再处理
    List<String> stackList = _fixStack(stackTrace);
    int ignoreDepth = 0;
    int allDepth = stackList.length;
    //倒着查询 查到倒数第一包名和需要屏蔽的包名一致时,数据往上的数据全部舍弃掉
    for (int i = allDepth - 1; i > -1; i--) {
      Match? match = _stackReg.matchAsPrefix(stackList[i]);
      //如果匹配且第一个子项也符合  group 0 表示全部 剩下的数字看子项的多少返回
      if (match != null &&
          (match.group(1)!.startsWith("package:$ignorePackage"))) {
        ignoreDepth = i + 1;
        break;
      }
    }
    stackList = stackList.sublist(ignoreDepth);
    return stackList;
  }

  /// 裁切堆栈
  /// [stackTrace] 堆栈
  /// [maxDepth] 深度
  static List<String> _cropStackTrace(List<String> stackTrace, int? maxDepth) {
    int realDeep = stackTrace.length;
    realDeep =
    maxDepth != null && maxDepth > 0 ? min(maxDepth, realDeep) : realDeep;
    return stackTrace.sublist(0, realDeep);
  }

  ///裁切获取到最终的stack 并获取最大深度的栈信息

  static getCroppedRealStackTrace(
      {required StackTrace stackTrace, ignorePackage, maxDepth}) {
    return _cropStackTrace(
        _getRealStackTrack(stackTrace, ignorePackage), maxDepth);
  }
}

///格式化堆栈信息
class StackFormatter implements ILogFormatter<List<String>> {
  @override
  String format(List<String> stackList) {
    ///每一行都设置成单独的 字符串
    StringBuffer sb = StringBuffer();

    ///堆栈是空的直接返回
    if (stackList.isEmpty) {
      return "";

      ///堆栈只有一行那么就返回 - 堆栈
    } else if (stackList.length == 1) {
      return "\n\t-${stackList[0].toString()}\n";

      ///多行堆栈格式化
    } else {
      for (int i = 0; i < stackList.length; i++) {
        if (i == 0) {
          sb.writeln("\n\t┌StackTrace:");
        }
        if (i != stackList.length - 1) {
          sb.writeln("\t├${stackList[i].toString()}");
        } else {
          sb.write("\t└${stackList[i].toString()}");
        }
      }
    }
    return sb.toString();
  }
}

///格式化JSON
class JsonFormatter extends ILogFormatter<Map<String, dynamic>> {
  @override
  String format(Map<String, dynamic> data) {
    ///递归调用循环遍历data 在StringBuffer中添加StringBuffer
    String finalString = _forEachJson(data, 0);
    finalString = "\ndata:$finalString";
    return finalString;
  }

  /// [data]  传入需要格式化的数据
  /// [spaceCount]  需要添加空格的长度 一个数字是两个空格
  /// [needSpace] 需不需要添加空格
  /// [needEnter] 需不需要回车
  String _forEachJson(dynamic data, int spaceCount,
      {bool needSpace = true, needEnter = true}) {
    StringBuffer sb = StringBuffer();
    int newSpace = spaceCount + 1;
    if (data is Map) {
      ///如果它是Map走这里
      ///是否需要空格
      sb.write(buildSpace(needSpace ? spaceCount : 0));
      sb.write(needEnter ? "{\n" : "{");
      data.forEach((key, value) {
        ///打印输出 key
        sb.write("${buildSpace(needEnter ? newSpace : 0)}$key: ");

        ///递归调用看value是什么类型 如果字符长度少于30就不回车显示
        sb.write(_forEachJson(value, newSpace,
            needSpace: false,
            needEnter: !(value is Map ? false : value.toString().length < 50)));

        ///不是最后一个就加,
        if (data.keys.last != key) {
          sb.write(needEnter ? ",\n" : ",");
        }
      });
      if (needEnter) {
        sb.writeln();
      }
      sb.write("${buildSpace(needEnter ? spaceCount : 0)}}");
    } else if (data is List) {
      ///如果他是列表 走这里
      sb.write(buildSpace(needSpace ? spaceCount : 0));
      sb.write("[${needEnter ? "\n" : ""}");
      for (var item in data) {
        sb.write(_forEachJson(item, newSpace,
            needEnter: !(item.toString().length < 30)));

        ///不是最后一个就加的,
        if (data.last != item) {
          sb.write(needEnter ? ",\n" : ",");
        }
      }
      sb.write(needEnter ? "\n" : "");
      sb.write("${buildSpace(needSpace?spaceCount:0)}]");
    } else if (data is num || data is bool) {
      ///bool 或者数组不加双引号
      sb.write(data);
    } else if (data is String) {
      ///string 或者其他的打印加双引号 如果他是回车就改变他 按回车分行会错乱
      sb.write("\"${data.replaceAll("\n", r"\n")}\"");
    } else {
      sb.write("$data");
    }
    return sb.toString();
  }

  ///构造空格
  String buildSpace(int deep) {
    String temp = "";
    for (int i = 0; i < deep; i++) {
      temp += "  ";
    }
    return temp;
  }
}

///调用LogUtil
class LogUtil {
  static const String _ignorePackageName = "log_demo/utils/log";

  static void V(
      {String? tag,
        dynamic message,
        LogConfig? logConfig,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.V,
        tag: tag ??= "",
        logConfig: logConfig,
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void E(
      {String? tag,
        dynamic message,
        LogConfig? logConfig,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.E,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static void I(
      {String? tag,
        dynamic message,
        LogConfig? logConfig,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.I,
        tag: tag ??= "",
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void D(
      {String? tag,
        dynamic message,
        LogConfig? logConfig,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.D,
        tag: tag ??= "",
        logConfig: logConfig,
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void A(
      {String? tag,
        LogConfig? logConfig,
        dynamic message,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.A,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static void W(
      {String? tag,
        dynamic message,
        LogConfig? logConfig,
        StackTrace? stackTrace,
        Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.W,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static Future<void> _logPrint({
    required LogType type,
    required String tag,
    LogConfig? logConfig,
    dynamic message,
    StackTrace? stackTrace,
    Map<String, dynamic>? json,
  }) async {
    ///如果logConfig为空那么就用默认的
    logConfig ??= LogManager().config;
    if (!logConfig?.enable) {
      return;
    }
    StringBuffer sb = StringBuffer();

    ///打印当前页面
    if (message.toString().isNotEmpty) {
      sb.write(message);
    }

    ///如果传入了栈且 要展示的深度大于0
    if (stackTrace != null && logConfig?.stackTraceDepth > 0) {
      sb.writeln();
      String stackTraceStr = StackFormatter().format(
          StackTraceUtil.getCroppedRealStackTrace(
              stackTrace: stackTrace,
              ignorePackage: _ignorePackageName,
              maxDepth: logConfig?.stackTraceDepth));
      sb.write(stackTraceStr);
    }
    if (json != null) {
      sb.writeln();
      String body = JsonFormatter().format(json);
      sb.write(body);
    }

    ///获取有几个打印器
    List<ILogPrint> prints = logConfig?.printers ?? LogManager().printers;
    if (prints.isEmpty) {
      return;
    }

    ///遍历打印器 分别打印数据
    for (ILogPrint print in prints) {
      print.logPrint(type: type, tag: tag, message: sb.toString());
    }
  }
}