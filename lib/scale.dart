import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

//菜单数组
final scaleList = [
  'scaleImage',
  'scaleChart',
  'scaleImage2',
];


class scaleDemoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ChartList"),
      ),
      body: new ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == scaleList.length) {
            return Container(); // zero height: not visible
          }
          else {
            return ListTile(
              title: Text(scaleList[index]),
              onTap: () {
                Navigator.pushNamed(context, scaleList[index]);
              },
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.blue,);
        },
        itemCount: scaleList.length + 1,
      ),
    );
  }
}
