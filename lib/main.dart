import 'package:flutter/material.dart';
import 'package:flutter_utils/pages/login/login.dart';

import 'components/log/console_print.dart';
import 'components/log/log_config.dart';
import 'components/log/log_manager.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    /* 打印日志 */
    LogManager.init(
        config: LogConfig(enable: true,globalTag: "TAG",stackTraceDepth: 5),
        printers: [ConsolePrint()]
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(child: LoginPage(),),
      ),

    );
  }
}
