import 'package:flutter/material.dart';
import './chat_viewer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Chat Viewer',
      // theme: ThemeData(
      //   primarySwatch: Colors.green
      // ),
      home: MyHomePage(title: 'WhatsApp Chat Viewer'),
    );
  }
}
