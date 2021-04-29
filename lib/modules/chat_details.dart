import 'package:flutter/material.dart';
// import 'package:whatsapp_chat_viewer/modules/chat_home_page.dart';
import '../model/chat_model.dart';
import 'chat_styles.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';
import 'dart:convert';
import 'parse_line.dart';
import 'dart:io';
import 'db_methods.dart';
import 'package:provider/provider.dart';

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
  final dbHelper = DatabaseHelper.instance;

  // Store name of self for right-side chat
  // Pending function to select or identy "self" in chat conversation
  
  String _selfName = 'John';

  Future<List<String>> _loadImportedChatConversation(
      WCVImportFile wcvObject) async {
    // chatConversation scoped to inner function
    List<String> chatConversation = [];

    // Parsing line with RegExp
    final _file = File(widget.wcvObject.filePath);
    await _file.readAsString().then((q) {
      LineSplitter ls = LineSplitter();
      String tmpStr = ""; // Empty String to build multiline body
      var chatLength = 0;
      List<String> _fileLines = ls.convert(q);
      for (String i in _fileLines) {
        if (regexP(i)) {
          // if line has <date><time> format start new List entry
          tmpStr = tmpStr + i;
          chatConversation.add(tmpStr);
          // print("chatConversation.add(tmpStr): $tmpStr");
          //
          // add to db: table and row
          //
          tmpStr = "";
        } else {
          // if line does NOT match <date><time> format then body string
          tmpStr = tmpStr + i;
          chatLength = chatConversation.length;

          if (chatLength == 0) {
            chatConversation.add(tmpStr);
            // print("chatLength == 0:  $tmpStr");
          } else {
            chatConversation[chatLength - 1] =
                chatConversation[chatLength - 1] + tmpStr;
            // print("previousString + tmpStr: $tmpStr");
          }
        }
        // chatConversation.add(i);

      }
      // print("chatConversation size: ${chatConversation.length}");
      // print("lines imported: ${_fileLines.length}");
      // print(
      //     "lines imported: ${_fileLines.toString()}"); // print _fileLines as string??
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
    // print(widget.wcvObject.filePath);
    print(widget.wcvObject.fileName);
    var tableName = formatFilename(widget.wcvObject.fileName);

    setState(() {
      _chatConversation = convertToChatObjects(chatConversation);
    });
    // Now batch insert chats as rows
    var results =
        await DatabaseHelper.instance.batchInsert(tableName, _chatConversation);
    print("results: $results");
    // query all rows of table
    // var myQuery = await DatabaseHelper.instance.queryRowCount();
    // print(myQuery);
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<SetUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wcvObject.fileName),
        backgroundColor: ChatStyles.whatsAppGreen,
      ),
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
                      style: _chatConversation[index].name == userName.name
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
