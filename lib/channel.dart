import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
*  此类主要用于与安卓api进行链接
 *  通过_MyChannel类去获取系统的电池情况
**/

class ChannelDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text("channel"),
        ),
        body: new MyChannel(),
      );
  }

}

class MyChannel extends StatefulWidget {
  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  static const platform = const MethodChannel('samples.flutter.io/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new ElevatedButton(
              child: new Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            new Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}