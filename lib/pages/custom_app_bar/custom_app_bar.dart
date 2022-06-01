
import 'package:flutter/material.dart';

class CustomAppBarPage extends StatefulWidget {
  const CustomAppBarPage({Key? key}) : super(key: key);


  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}
class _CustomAppBarState extends State<CustomAppBarPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: Row(
          children: [
            const SizedBox(width: 5,),
            Container(

              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(91, 87, 150, 1),
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
              child: const Align(
                child: Text('泡泡',style: TextStyle(fontSize: 14,color: Colors.white),),
              ),
            ),
            const SizedBox(width: 5,),
          ],
        ),
        title: const Text('消息',style: TextStyle(fontSize: 18.0,color: Color.fromRGBO(67, 68, 71, 1),fontWeight: FontWeight.w500),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ],
        ),
      ),
    );
  }

}