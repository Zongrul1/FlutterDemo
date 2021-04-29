import 'package:flutter/material.dart';

/**
*  此类作为图表类菜单
**/


//菜单数组
final chartList = [
  'barchart',
  'linechart',
  'piechart',
  'sankey',
];

class Chart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("ChartList"),
        ),
        body: new ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (index == chartList.length) {
                return Container(); // zero height: not visible
              }
              else {
                return ListTile(
                  title: Text(chartList[index]),
                  onTap: () {
                    Navigator.pushNamed(context, chartList[index]);
                  } ,
                );
              }
            },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.blue,);
          },
            itemCount: chartList.length + 1,
        ),
      );
  }
}