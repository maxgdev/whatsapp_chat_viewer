import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/chat_home_page.dart';
import './my_db_home.dart';


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
      theme: ThemeData(
        primarySwatch: Colors.green,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      home: MyDBHomePage(),
      // home: ChatHomePage(title: 'WhatsApp Chat Viewer'),
    );
  }
}
