import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Sample2 extends StatelessWidget {
  final _focusSample = FocusNode();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample 2"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: Center(
          child: KeyboardActions(
            tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
            config: KeyboardActionsConfig(
              keyboardSeparatorColor: Colors.purple,
              actions: [
                KeyboardActionsItem(
                  focusNode: _focusSample,
                  displayArrows: false,
                  displayActionBar: false,
                  footerBuilder: (context) {
                    return MyCustomBarWidget(
                      node: _focusSample,
                      controller: _textController,
                    );
                  },
                ),
              ],
            ),
            child: ListView(
              children: [
                TextField(
                  controller: _textController,
                  focusNode: _focusSample,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Sample Input",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode? node;
  final TextEditingController? controller;

  const MyCustomBarWidget({
    Key? key,
    this.node,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.access_alarm),
            onPressed: () => print('hello world 1')),
        IconButton(
            icon: const Icon(Icons.send), onPressed: () {
              print(controller!.text);
            }
        ),
        const Spacer(),
        IconButton(icon: const Icon(Icons.close), onPressed: () => node!.unfocus()),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
