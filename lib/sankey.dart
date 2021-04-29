import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_echarts/flutter_echarts.dart';
// import 'package:number_display/number_display.dart';


class MySankeyChart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("Sankey Demo"),
        ),
        body: ListView(
            children: [
              new SankeyDemo1(),
              new SankeyDemo2(),
          ],
        )
      );
  }
}

class SankeyDemo1 extends StatefulWidget{
  @override
  _SankeyDemo1State createState() => _SankeyDemo1State();
}

class _SankeyDemo1State extends State<SankeyDemo1>{


  @override
  Widget build(BuildContext context) {

      const List<Map<String, Object>> _citylist = [
        {'name': '北京'},
        {'name': '上海'},
        {'name': '广州'},
        {'name': '深圳'},
        {'name': '香港'}
      ];

      const List<Map<String, Object>> _population=[
        {'source': "广州", 'target': "北京", 'value': 4567},
        {'source': "广州", 'target': "上海", 'value': 2060},
        {'source': "深圳", 'target': "北京", 'value': 1234},
        {'source': "深圳", 'target': "上海", 'value': 124},
        {'source': "香港", 'target': "北京", 'value': 3714},
        {'source': "香港", 'target': "上海", 'value': 3234}
      ];

      return new Container(
        height: 400,
        child: new Echarts(option:
          '''{
                  series: {
            type: 'sankey',
            layout: 'none',
            emphasis: {
                focus: 'adjacency'
            },
            data: ${jsonEncode(_citylist)},
            links: ${jsonEncode(_population)},
          }
        }
          '''
        ),
      );
  }
}

class SankeyDemo2 extends StatefulWidget{
  @override
  _SankeyDemo2State createState() => _SankeyDemo2State();
}

class _SankeyDemo2State extends State<SankeyDemo2>{
  @override
  Widget build(BuildContext context) {
    const List<Map<String, Object>> _data = [{
      'name': 'a'
    }, {
      'name': 'b'
    }, {
      'name': 'a1'
    }, {
      'name': 'a2'
    }, {
      'name': 'b1'
    }, {
      'name': 'c'
    }];

    const List<Map<String, Object>> _links = [{
      'source': 'a',
      'target': 'a1',
      'value': 5
    }, {
      'source': 'a',
      'target': 'a2',
      'value': 3
    }, {
      'source': 'b',
      'target': 'b1',
      'value': 8
    }, {
      'source': 'a',
      'target': 'b1',
      'value': 3
    }, {
      'source': 'b1',
      'target': 'a1',
      'value': 1
    }, {
      'source': 'b1',
      'target': 'c',
      'value': 2
    }];

    return new Container(
      height: 400,
      child: new Echarts(option:
      '''{
            series: {
              type: 'sankey',
              layout: 'none',
              color: ['#000000', '#32C5E9', '#67E0E3', '#9FE6B8', '#FFDB5C','#ff9f7f', '#fb7293', '#E062AE', '#E690D1', '#e7bcf3', '#9d96f5', '#8378EA', '#96BFFF'],
              emphasis: {
                  focus: 'adjacency'
              },
              data: ${jsonEncode(_data)},
              links: ${jsonEncode(_links)},
            }
        }
          '''
      ),
    );
  }


}

