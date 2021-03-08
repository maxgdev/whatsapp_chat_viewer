import 'package:flutter/material.dart';
import 'chats.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  void _incrementCounter() {
    setState(() {
      //
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF25d366),
        title: Text(widget.title),
      ),
      body: Chats(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add Chat',
        backgroundColor: Color(0xFF25d366),
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
