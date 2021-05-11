import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import 'package:whatsapp_chat_viewer/modules/parse_utils.dart';
import '../model/chat_model.dart';
import '../providers/providers.dart';
import 'db_methods.dart';
import 'chat_styles.dart';
// import 'parse_utils.dart';

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

  // var myQuery = DatabaseHelper.instance.queryAllRows(widget.wcvObject.tableName);

  @override
  Widget build(BuildContext context) {
    final userSettingsVar = Provider.of<UserSettings>(context);
    // Format table name from widget.wcvObject.fileName
    var fileName = widget.wcvObject.fileName;
    var tableName = formatFilename(fileName);
    Provider.of<ChatConversations>(context).chatFromDb(tableName);

    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
        backgroundColor: ChatStyles.whatsAppGreen,
      ),
      // Add Consumer to body widget for MultiProvider consumption
      body: Consumer<ChatConversations>(
        builder: (context, chatList, child) => Container(
          decoration: ChatStyles.containerBackgroundImage,
          child: ListView.builder(
            // itemCount: chatObj.conversationLength(tableName),
            itemCount: chatList.chatConversation.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Bubble(
                        style: chatList.chatConversation[index].name ==
                                userSettingsVar.name
                            ? ChatStyles.styleMe
                            : chatList.chatConversation[index].name == ""
                                ? ChatStyles.noStyle
                                : ChatStyles.styleSomebody,
                        margin: BubbleEdges.only(top: 4),
                        showNip: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${chatList.chatConversation[index].name}",
                              style: ChatStyles.chatNameStyle,
                            ),
                            Text("${chatList.chatConversation[index].message}"),
                            chatBottomRow(chatList.chatConversation[index].date,
                                chatList.chatConversation[index].time),
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
