import 'package:flutter/material.dart';
import '../model/chat_model.dart';
import 'chat_colors.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';
import 'dart:convert';
import 'parse_line.dart';
import 'dart:io';
import 'db_methods.dart';

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
          //
          // add to db: table and row
          //
          tmpStr = "";
          // print('match');
        } else {
          // if line does NOT match <date><time> format then body string
          tmpStr = tmpStr + i;
          chatLength = chatConversation.length;
          // print(chatLength);
          if (chatLength == 0) {
            chatConversation.add(tmpStr);
          } else {
            chatConversation[chatLength - 1] = tmpStr;
          }
        }
        // chatConversation.add(i);

      }
      // print("chatConversation size: ${chatConversation.length}");
      // print("lines imported: ${_fileLines.length}");
      // print(
      //     "lines imported: ${_fileLines.toString()}"); // print _fileLines as string??
    });

    // --------------------------------------------------------
    // Convert chatConversation List into Chat Objects List
    // convert chatConversation in db entries
    //---------------------------------------------------------

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
    print(widget.wcvObject.filePath);
    print(widget.wcvObject.fileName);
    var tableName = formatFilename(widget.wcvObject.fileName);

    setState(() {
      _chatConversation = convertToChatObjects(chatConversation);
      // Now batch insert chats as rows
    });

    var results = await DatabaseHelper.instance.batchInsert(tableName, _chatConversation);
    // print("results: $results");
    // query all rows of table
    // var myQuery = await DatabaseHelper.instance.queryRowCount();
    // print(myQuery);
    
  }

  static const styleSomebody = BubbleStyle(
    // nip: BubbleNip.leftCenter,
    nip: BubbleNip.leftBottom,
    color: Colors.white,
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    // nip: BubbleNip.rightCenter,
    nip: BubbleNip.rightBottom,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        // title: Text(chat.name),
        title: Text(widget.wcvObject.fileName),
        backgroundColor: ChatColors.whatsAppGreen,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/whatsapp_wallpaper.png"),
              fit: BoxFit.cover),
        ),
        // color: Colors.yellow.withAlpha(64),
        child: ListView.builder(
          itemCount: _chatConversation.length,
          itemBuilder: (context, index) {
            // return Text(_chatConversation[index]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // CircleAvatar(
                  //   backgroundColor: ChatColors.whatsAppGreen,
                  //   child: Text("${parseLine(_chatConversation[index], 2)[1]}"),
                  // ),
                  Expanded(
                    child: Bubble(
                      style: _chatConversation[index].name ==
                              // style: parseLine(_chatConversation[index], 2).trim() ==
                              _selfName
                          ? styleMe
                          : styleSomebody,
                      margin: BubbleEdges.only(top: 4),
                      showNip: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_chatConversation[index].name}",
                            // "${parseLine(_chatConversation[index], 2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: ChatColors.whatsAppGreen),
                          ),
                          Text("${_chatConversation[index].message}"),
                          // Text("${parseLine(_chatConversation[index], 3)}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Text(
                                      "${_chatConversation[index].date}",
                                      // "${parseLine(_chatConversation[index], 0)}",
                                      style: TextStyle(fontSize: 9))),
                              Text("${_chatConversation[index].time}",
                                  // Text("${parseLine(_chatConversation[index], 1)}",
                                  style: TextStyle(fontSize: 9)),
                            ],
                          ),
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

// Database methods

//   void _insert(rowElement) async {
//     // row to insert
//     Map<String, dynamic> row = {
//       DatabaseHelper.chatName: "Test Name",
//       DatabaseHelper.chatMessage: "Test Message",
//     };
//     final id = await dbHelper.insert(row);
//     print('inserted row id: $id');
//   }

//   void _query() async {
//     final allRows = await dbHelper.queryAllRows();
//     print('query all rows:');
//     allRows.forEach((row) => print(row));
//   }

//   // void _update() async {
//   //   // row to update
//   //   Map<String, dynamic> row = {
//   //     DatabaseHelper.columnId: 1,
//   //     DatabaseHelper.columnName: 'WhatsApp Chat 30/03/2021',
//   //     DatabaseHelper.columnList: [],
//   //   };
//   //   final rowsAffected = await dbHelper.update(row);
//   //   print('updated $rowsAffected row(s)');
//   // }

//   void _delete() async {
//     // Assuming that the number of rows is the id for the last row.
//     final id = await dbHelper.queryRowCount();
//     final rowsDeleted = await dbHelper.delete(id);
//     print('deleted $rowsDeleted row(s): row $id');
//   }
}
