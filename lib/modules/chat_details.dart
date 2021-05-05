import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import '../model/chat_model.dart';
import '../providers/providers.dart';
import 'chat_styles.dart';
import 'parse_utils.dart';
import 'db_methods.dart';
import 'dart:async';
import 'dart:io';

class ChatDetailsScreen extends StatefulWidget {
  ChatDetailsScreen({Key key, this.wcvObject}) : super(key: key);

  final WCVImportFile wcvObject;

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  // _chatConversation scoped to function
  List<Chat> _chatConversation = [];

  // reference to our single class that manages the database

  // final dbHelper = DatabaseHelper.instance;

  Future<List<String>> _loadImportedChatConversation(
      WCVImportFile wcvObject) async {
    // chatConversation scoped to inner function
    List<String> chatConversation = [];

    // Parsing line with RegExp
    final _file = File(widget.wcvObject.filePath);
    await _file.readAsString().then((q) {
      extractToChat(chatConversation, q);
    });

    return chatConversation;
  } // _loadImportedChatConversation

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    List<String> chatConversation =
        await _loadImportedChatConversation(widget.wcvObject);

    setState(() {
      _chatConversation = convertToChatObjects(chatConversation);
    });

    // Now batch insert chats as rows

    // print(widget.wcvObject.fileName);
    // var tableName = formatFilename(widget.wcvObject.fileName);
    // var results =
    //     await DatabaseHelper.instance.batchInsert(tableName, _chatConversation);
    // print("results: $results");

    // query all rows of table
    // var myQuery = await DatabaseHelper.instance.queryRowCount();
    // print(myQuery);
  }

  @override
  Widget build(BuildContext context) {
    final userSettingsVar = Provider.of<UserSettings>(context);
    final chats = Provider.of<ChatConversations>(context);
    List _chatConversation = chats.chatConversation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wcvObject.fileName),
        backgroundColor: ChatStyles.whatsAppGreen,
      ),
      // Add Consumer to body widget for MultiProvider consumption
      body: Container(
        decoration: ChatStyles.containerBackgroundImage,
        child: ListView.builder(
          itemCount: _chatConversation.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Bubble(
                      style: _chatConversation[index].name == userSettingsVar.name
                          ? ChatStyles.styleMe
                          : _chatConversation[index].name == ""
                              ? ChatStyles.noStyle
                              : ChatStyles.styleSomebody,
                      margin: BubbleEdges.only(top: 4),
                      showNip: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_chatConversation[index].name}",
                            style: ChatStyles.chatNameStyle,
                          ),
                          Text("${_chatConversation[index].message}"),
                          chatBottomRow(_chatConversation[index].date,
                              _chatConversation[index].time),
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
