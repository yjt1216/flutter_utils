import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/match_text.dart';
import '../../utils/prased_text_utils.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}
class _DynamicPageState extends State<DynamicPage> {

  List rightTitles = ['测试数据就是这样怎么了','这个短','这个长是不是是','我就是随便写写','是短','这个长不长也','就那样也不长','谁说的这个是最后的我就写长点儿你能拿我怎么办打不到我吧我就是这么强大'];

  String testText = '不要将希望寄托于未来，寄托于那些不确定的东西。好好把握现在，把握生命里最灿烂的年华与青春，该来的来，该走的由他走，无论你有多么的不舍、不愿意，一个人决心要离开你，你始终是想拦也拦不住的。';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('文本换行'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0,top: 10.0),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: rightTitles.map((childNode){
                return GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Container(
                        padding:  const EdgeInsets.all(3.0),
                        color: getRandomColor(),
                        child: Text(
                          childNode,
                          style: const TextStyle(
                            fontSize:14,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.2, 0.2)
                              )],
                          ),
                        ),
                      ),
                    )
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0,),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Container(
                    padding:  const EdgeInsets.all(3.0),
                    color: getRandomColor(),
                    child: Text(
                      testText,
                      style: const TextStyle(
                        fontSize:14,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.2, 0.2)
                          )],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),

            textContent(testText, context, true),
            const SizedBox(height: 10.0,),

          ],
        ),
      ),
    );
  }


  getRandomColor(){
    return Color.fromARGB(255, Random.secure().nextInt(255), Random.secure().nextInt(255), Random.secure().nextInt(255));
  }


  Widget textContent(String mTextContent, BuildContext context, bool isDetail) {
    if (!isDetail) {
      //如果字数过长
      if (mTextContent.length > 150) {
        mTextContent = mTextContent.substring(0, 148) + ' ... ' + '全文';
      }
    }
    mTextContent = mTextContent.replaceAll("\\n", "\n");
    return Container(
      color: Colors.green,
        alignment: FractionalOffset.centerLeft,
        margin: const EdgeInsets.only(top: 5.0, left: 15, right: 15, bottom: 5),
        child: ParsedText(
          text: mTextContent,
          style: const TextStyle(
            height: 1.5,
            fontSize: 15,
            color: Colors.black,
          ),
          parse: <MatchText>[
            MatchText(
                pattern: r"\[(@[^:]+):([^\]]+)\]",
                style: const TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String? str, String? pattern}) {
                  Map<String, String> map = <String, String>{};
                  RegExp customRegExp = RegExp(pattern!);
                  Match? match = customRegExp.firstMatch(str!);
                  map['display'] = match!.group(1)!;
                  map['value'] = match.group(2)!;
                  print("正则:" + match.group(1)! + "---" + match.group(2)!);
                  return map;
                },
                onTap: (content, contentId) {


                }),
            MatchText(
                pattern: '#.*?#',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: const TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String? str, String? pattern}) {
                  Map<String, String> map = <String, String>{};

                  String idStr =
                  str!.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
                  String showStr = str
                      .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                      .replaceAll(":" + idStr, "");
                  map['display'] = showStr;
                  map['value'] = idStr;
                  //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                  return map;
                },
                onTap: (String content, String contentId) async {
                  print("id是:" + contentId.toString());
                  /*Routes.navigateTo(
                  context,
                  Routes.topicDetailPage,
                  params: {
                    'mTitle': content.replaceAll("#", ""),
                    'mImg': "",
                    'mReadCount': "123",
                    'mDiscussCount': "456",
                    'mHost': "测试号",
                  },
                );*/
                }),
            MatchText(
              pattern: '(\\[/).*?(\\])',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: const TextStyle(
                fontSize: 15,
              ),
              renderText: ({String? str, String? pattern}) {
                Map<String, String> map = Map<String, String>();
                print("表情的正则:" + str!);
                String mEmoji2 = "";
                try {
                  String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
                  int mEmojiNew = int.parse(mEmoji);
                  mEmoji2 = String.fromCharCode(mEmojiNew);
                } on Exception catch (_) {
                  mEmoji2 = str;
                }
                map['display'] = mEmoji2;

                return map;
              }, onTap: (){},
            ),
            MatchText(
                pattern: '全文',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: const TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15,
                ),
                renderText: ({String? str, String? pattern}) {
                  Map<String, String> map = <String, String>{};
                  map['display'] = '全文';
                  map['value'] = '全文';
                  return map;
                },
                onTap: (display, value) async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Mentions clicked"),
                        content: const Text("点击全文了"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          FlatButton(
                            child: const Text("Close"),
                            onPressed: () {},
                          ),
                        ],
                      );
                    },
                  );
                }),
          ], onTap: () {  },
        ));
  }


}

