import 'package:flutter/material.dart';
import 'package:flutter_app2/layout.dart' as Layout;
import 'package:flutter_app2/route.dart' as Route;
import 'package:flutter_app2/chart.dart' as Chart;
import 'package:flutter_app2/barchart.dart' as BarChart;
import 'package:flutter_app2/linechart.dart' as LineChart;
import 'package:flutter_app2/piechart.dart' as PieChart;
import 'package:flutter_app2/sankey.dart' as Sankey;
import 'package:flutter_app2/input.dart' as Input;

void main() {
  runApp(new SampleApp());
}

final indexList = [
  'layout',
  'httpRequest',
  'chart',
  'input',
];

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
      },
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Demo List"),
        ),
        body: new IndexList(),
      ),
    );
  }
}
