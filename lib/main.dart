import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_app2/layout.dart' as Layout;
import 'package:flutter_app2/route.dart' as Route;
import 'package:flutter_app2/chart.dart' as Chart;
import 'package:flutter_app2/barchart.dart' as BarChart;
import 'package:flutter_app2/linechart.dart' as LineChart;
import 'package:flutter_app2/piechart.dart' as PieChart;
import 'package:flutter_app2/sankey.dart' as Sankey;
import 'package:flutter_app2/input.dart' as Input;
import 'package:flutter_app2/channel.dart' as Channel;
import 'package:flutter_app2/scale.dart' as Scale;
import 'package:flutter_app2/scaleImage.dart' as ScaleImage;
import 'package:flutter_app2/scaleChart.dart' as ScaleChart;
import 'package:flutter_app2/scaleImage2.dart' as ScaleImage2;

class Application {
  ///应用全局 ke
  static GlobalKey<NavigatorState>  globalKey;
  static OverlayEntry overlayEntry;
}


void main() {
  GlobalKey<NavigatorState> globalKey = new  GlobalKey<NavigatorState>();
  Application.globalKey = globalKey;
  runApp(new SampleApp());
}

final indexList = [
  'layout',
  'httpRequest',
  'chart',
  'input',
  'channel',
  'scale'
];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry overlayEntry;
  double _top = 100.0; //距顶部的偏移
  double _left = 100.0;//距左边的偏移
  //最后一次down事件的offset
  Offset lastOffset=Offset(0, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///WidgetsBinding.instance.addPostFrameCallback 这个作用是界面绘制完成的监听回调  必须在绘制完成后添加OverlayEntry
      ///MediaQuery.of(context).size.width  屏幕宽度
      ///MediaQuery.of(context).size.height 屏幕高度
      addOverlayEntry();
    });


  }

  void addOverlayEntry() {
    Application.overlayEntry?.remove();
    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Stack(
            children: <Widget>[
              Positioned(
                top:  _top,
                left: _left,
                child: GestureDetector(
                    onTap: () async{

                    },
                    child: Icon(Icons.add_call, color: Colors.red,),
                    onScaleStart: (ScaleStartDetails e){
                      lastOffset = e.focalPoint;
                    },
                    onScaleUpdate: (ScaleUpdateDetails e) {
                      setState(() {
                        //缩放比例以及移动
                        Application.overlayEntry?.remove();
                        _left += (e.focalPoint.dx - lastOffset.dx);
                        _top += (e.focalPoint.dy - lastOffset.dy);
                        lastOffset = e.focalPoint;
                        });
                      Application.overlayEntry = overlayEntry;
                      Application.globalKey.currentState.overlay.insert(overlayEntry);

                    },
                    onScaleEnd: (ScaleEndDetails e) {
                      //浮窗的位置改动
                      Application.overlayEntry?.remove();
                      Application.overlayEntry = overlayEntry;
                      Application.globalKey.currentState.overlay.insert(overlayEntry);
                    },
                ),
            ),
          ],
        )
    );
    /// 赋值  方便移除
    Application.overlayEntry = overlayEntry;
    Application.globalKey.currentState.overlay.insert(overlayEntry);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexList(),
    );
  }
}

class IndexList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Widget divider=Divider(color: Colors.blue,);
    ListView listView = new ListView.separated(
      itemCount: indexList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == indexList.length) {
          return Container(); // zero height: not visible
        }
        else {
          return ListTile(
              title: Text(indexList[index]),
              onTap: () {
                Navigator.pushNamed(context, indexList[index]);
              } ,
          );
        }
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return divider;
      },
    );
    return listView;
  }
}


class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "httpRequest": (context) => Route.NewRoute(),
        "layout": (context) => Layout.Layout(),
        "chart": (context) => Chart.Chart(),
        "barchart": (context) => BarChart.MyBarChart(),
        "linechart": (context) => LineChart.MyLineChart(),
        "piechart": (context) => PieChart.MyPieChart(),
        "sankey": (context) => Sankey.MySankeyChart(),
        "input": (context) => Input.textInputDemo(),
        "channel": (context) => Channel.ChannelDemo(),
        "scale": (context) => Scale.scaleDemoWidget(),
        "scaleImage": (context) => ScaleImage.scaleImageDemoWidget(),
        "scaleChart": (context) => ScaleChart.scaleChartDemoWidget(),
        "scaleImage2": (context) => ScaleImage2.scaleImageDemoWidget(),
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: Application.globalKey,
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Demo List"),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

