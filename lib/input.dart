import 'package:flutter/material.dart';

class textInputDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text("input"),
        ),
        body: new textInputSample(),
      );
  }

}


class textInputSample extends StatefulWidget{
  @override
  _textInputSampleState createState() {
      return new _textInputSampleState();
  }
}

class _textInputSampleState extends State<textInputSample>{
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(100),
            child: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: 'Type something',
              ),
            ),
          ),
          new ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => new AlertDialog(
                  title: new Text('What you typed'),
                  content: new Text(_controller.text),
                ),
              );
            },
            child: new Text('DONE'),
          ),
        ],
      );
    }
  }