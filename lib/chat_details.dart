import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/chat_model.dart';
import 'chat_colors.dart';

class ChatDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 
    final Chat chat = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
        backgroundColor: ChatColors.whatsAppGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: ListTile(
            title: Text(chat.name),
            subtitle: Text(chat.message),
            trailing: Text(chat.time),
          ),
        ),
      ),
    );
  }
}
