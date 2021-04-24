import 'package:flutter/material.dart';
import './modules/chat_home_page.dart';
import './modules/chat_colors.dart';

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
        primarySwatch: createMaterialColor(Color(0xff0E6655)),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      home: ChatHomePage(title: 'WhatsApp Chat Viewer'),
    );
  }
}
