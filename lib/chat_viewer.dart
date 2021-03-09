import 'package:flutter/material.dart';
import 'chats.dart';
import './chat_colors.dart';
// import './chats_test.dart';
class ChatHomePage extends StatefulWidget {
  ChatHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  

  void _addChatFile() {
    setState(() {
      // open file/path manager
      // select file - text ONLY
      // check file format and parse
      // add file contents as new chat stream
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whatsAppGreen,
        title: Text(widget.title),
      ),
      body: Chats(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addChatFile,
        tooltip: 'Add Chat',
        backgroundColor: ChatColors.whatsAppGreen,
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
