import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

/**
    scaleImage
    利用了 Stack Positioned 去实现了绝对布局
    然后通过GestureDetector实现对图片的缩放以及拖拽
 **/



class scaleImageDemoWidget extends StatefulWidget{
  @override
  _scaleImageDemoState createState() => new _scaleImageDemoState();

}

class _scaleImageDemoState extends State<scaleImageDemoWidget>{

  double _scale = 1.0;
  double _top = 100.0; //距顶部的偏移
  double _left = 100.0;//距左边的偏移
  double curScale;
  Offset _lastOffset;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("手势检测"),),
      body:
      Center(
        child: Stack(
          children: <Widget>[
              Positioned(
                //用于定位
              top: _top,
              left: _left,
              child: GestureDetector(
                  child: Transform(
                    alignment: FractionalOffset.center,
                    //分析 Vector3 两种构造方法，三个参数分别对应 x / y /z 轴方向缩放；
                    transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                    child:Image.asset(
                        'images/lake.jpg',
                        width: 200,
                        height: 200,
                    ),
                  ),
                  //缩放
                  onScaleStart: (ScaleStartDetails e){
                    //初始化一开始的缩放比例
                    curScale = _scale;
                    _lastOffset = e.focalPoint;
                  },
                  onScaleUpdate: (ScaleUpdateDetails e) {
                    setState(() {
                      //缩放比例以及移动
                      _scale= curScale * e.scale;
                      _left += (e.focalPoint.dx - _lastOffset.dx);
                      _top += (e.focalPoint.dy - _lastOffset.dy);
                       _lastOffset = e.focalPoint;
                    });
                  },
                  onScaleEnd: (ScaleEndDetails e) {
                    curScale = _scale;
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }

}