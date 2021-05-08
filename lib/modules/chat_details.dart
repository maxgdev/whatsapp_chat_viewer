import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import '../model/chat_model.dart';
import '../providers/providers.dart';
import 'chat_styles.dart';
// import 'parse_utils.dart';
// import 'db_methods.dart';
// import 'dart:async';
// import 'dart:io';

class ChatDetailsScreen extends StatefulWidget {
  ChatDetailsScreen({Key key, this.wcvObject}) : super(key: key);

  final WCVImportFile wcvObject;

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  // _chatConversation scoped to function
  // List<Chat> _chatConversation = [];

  @override
  Widget build(BuildContext context) {
    final userSettingsVar = Provider.of<UserSettings>(context);
    // Provider.of<ChatConversations>(context).readConversations(widget.wcvObject);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wcvObject.fileName),
        backgroundColor: ChatStyles.whatsAppGreen,
      ),
      // Add Consumer to body widget for MultiProvider consumption
      body: Consumer<ChatConversations>(
        builder: (context, chatObj, child) => Container(
          decoration: ChatStyles.containerBackgroundImage,
          child: ListView.builder(
            itemCount: chatObj.conversationLength(widget.wcvObject),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Bubble(
                        style: chatObj.chatConversation[index].name ==
                                userSettingsVar.name
                            ? ChatStyles.styleMe
                            : chatObj.chatConversation[index].name == ""
                                ? ChatStyles.noStyle
                                : ChatStyles.styleSomebody,
                        margin: BubbleEdges.only(top: 4),
                        showNip: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${chatObj.chatConversation[index].name}",
                              style: ChatStyles.chatNameStyle,
                            ),
                            Text("${chatObj.chatConversation[index].message}"),
                            chatBottomRow(chatObj.chatConversation[index].date,
                                chatObj.chatConversation[index].time),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget chatBottomRow(String date, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text("$date", style: ChatStyles.chatInfoStyle)),
        Text("$time", style: ChatStyles.chatInfoStyle),
      ],
    );
  }
}
