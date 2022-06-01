import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollViewPage extends StatefulWidget{
  const ScrollViewPage({Key? key}) : super(key: key);

  @override
  _ScrollViewState createState() => _ScrollViewState();
}
class _ScrollViewState extends State<ScrollViewPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                color: Colors.blue,
                child: RichText(
                  text: TextSpan(
                    text: '登陆即同意登陆即同意登陆即同意登陆即同意登陆即同意',
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '《服务条款》',
                        style: const TextStyle(color: Colors.red),
                        //文本的点击事件
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(
                        text: '和',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '《隐私政策》',
                        style: const TextStyle(color: Colors.red),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                )

              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      color: Colors.orange,
                      height: 56.0,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Container(
                    height: 12,
                    color: Colors.white70,
                  ),
                  itemCount: 20,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );


  }


}