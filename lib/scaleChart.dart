import 'package:flutter/material.dart';
import 'package:flutter_app2/piechart.dart' as PieChart;

/**
    scaleChart
    使用InteractiveViewer实现
 **/


class scaleChartDemoWidget extends StatefulWidget{
  @override
  _scaleChartDemoState createState() => new _scaleChartDemoState();

}

class _scaleChartDemoState extends State<scaleChartDemoWidget>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("手势检测"),),
      body: Center(
        child: InteractiveViewer(
        alignPanAxis: false,
        //对子Widget 进行缩放平移
        child: PieChart.PieChartSample3()
      ),
      ),
    );
  }

}