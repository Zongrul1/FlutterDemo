import 'package:flutter/material.dart';

/**
    scaleImage2
    使用InteractiveViewer实现
 **/

class scaleImageDemoWidget extends StatefulWidget{
  @override
  _scaleImageDemoState createState() => new _scaleImageDemoState();

}

class _scaleImageDemoState extends State<scaleImageDemoWidget>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("手势检测"),),
      body: Center(
        child: InteractiveViewer(
        alignPanAxis: false,
        //对子Widget 进行缩放平移
        child: Image.asset('images/lake.jpg',),
      ),
      ),
    );
  }

}