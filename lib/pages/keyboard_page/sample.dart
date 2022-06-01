import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Sample extends StatelessWidget {
  final _focusNodeName = FocusNode();
  final _focusNodeQuantity = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.place),
        onPressed: () {
          _focusNodeName.requestFocus();
        },
      ),
      appBar: AppBar(
        title: const Text("KeyboardActions"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: Center(
          child: Theme(
            data: Theme.of(context).copyWith(
              disabledColor: Colors.blue,
              iconTheme: IconTheme.of(context).copyWith(
                color: Colors.red,
                size: 35,
              ),
            ),
            child: KeyboardActions(
              tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
              config: KeyboardActionsConfig(
                keyboardSeparatorColor: Colors.purple,
                actions: [
                  KeyboardActionsItem(
                    focusNode: _focusNodeName,
                  ),
                  KeyboardActionsItem(
                    focusNode: _focusNodeQuantity,
                  ),
                ],
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height / 4,
                    child: const FlutterLogo(),
                  ),
                  TextField(
                    focusNode: _focusNodeName,
                    decoration: const InputDecoration(
                      // labelText: "登录名包含 数字,英文,字符中的两种以上，长度6-20",
                      label: Text("登录名包含 数字,英文,字符中的两种以上，长度6-20",style: TextStyle(fontSize: 14),),
                    ),
                  ),
                  TextField(
                    focusNode: _focusNodeQuantity,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      // labelText: "密码包含 数字,英文,字符中的两种以上，长度7-20",
                      label: Text("密码包含 数字,英文,字符中的两种以上，长度7-20",style: TextStyle(fontSize: 14),),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
