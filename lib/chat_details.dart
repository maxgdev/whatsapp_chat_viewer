import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './chat_model.dart';
// import 'package:whatsapp_chat_viewer/file_list.dart';
// import 'package:whatsapp_chat_viewer/chat_model.dart';
import 'chat_colors.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';
import 'dart:convert';
import './parse_line.dart';
import 'dart:io';

class ChatDetailsScreen extends StatefulWidget {
  ChatDetailsScreen({Key key, this.wcvObject}) : super(key: key);

  final WCVImportFile wcvObject;

  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  // _chatConversation scoped to function
  List<String> _chatConversation = [];

  // Store name of self for right-side chat
  // Pending function to select or identy "self" in chat conversation
  String _selfName = 'John';

  // _loadChatConversation for LOADING DUMMY Conversation
  // ----------------------------------------------------
  // Future<List<String>> _loadChatConversation() async {
  //   // chatConversation scoped to inner function
  //   List<String> chatConversation = [];
  //   // Loading sample chat for development ONLY
  //   // production is selected from device/SD card
  //   await rootBundle.loadString('assets/chatsample.txt').then((q) {
  //     for (String i in LineSplitter().convert(q)) {
  //       chatConversation.add(i);
  //     }
  //   });
  //   return chatConversation;
  // }

  Future<List<String>> _loadImportedChatConversation(
      WCVImportFile wcvObject) async {
    // chatConversation scoped to inner function
    List<String> chatConversation = [];

    // production is selected from device/SD card
    // await rootBundle.loadString("${wcvObject.filePath}").then((q) {
    //   for (String i in LineSplitter().convert(q)) {
    //     print(i); // diagnostic
    //     chatConversation.add(i);
    //   }
    // });
    // Match line with dd/mm/yy, hh:mm - ONLY
    RegExp lineExp = RegExp(
        r"(\s*[0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s-)",
        caseSensitive: false,
        multiLine: true);

    final _file = File(widget.wcvObject.filePath);
    await _file.readAsString().then((q) {
      LineSplitter ls = LineSplitter();
      List<String> _fileLines = ls.convert(q);
      for (String i in _fileLines) {
        print(i); //
        print(lineExp.firstMatch("$i"));
        print(lineExp.hasMatch(i.toString()));
        print(lineExp.hasMatch("8/1/19, 12:09 PM - Sam: Missed voice call"));
        // if(lineExp.hasMatch("18/06/17, 22:45 - Nick Fury added you") {
        //   //impement
        //   print("if TRUE section");
        //   chatConversation.add(i);
        //   print("chatConversation size: ${chatConversation.length}");
        // }
        // else {
        //   // implement
        //   print("else section");

        // }
      }
    });

    return chatConversation;
  }

// --------------------------------------------------------

// --------------------------------------------------------
  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    // List<String> chatConversation = await _loadChatConversation();
    // final WCVImportFile chatFile = ModalRoute.of(context).settings.arguments;

    List<String> chatConversation =
        await _loadImportedChatConversation(widget.wcvObject);
    print(widget.wcvObject.filePath);
    // Notify the UI and display the questions
    setState(() {
      _chatConversation = chatConversation;
    });
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
    // final Chat chat = ModalRoute.of(context).settings.arguments;
    // final WCVImportFileList fileList = ModalRoute.of(context).settings.arguments;

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
                      style: parseLine(_chatConversation[index], 2).trim() ==
                              _selfName
                          ? styleMe
                          : styleSomebody,
                      margin: BubbleEdges.only(top: 4),
                      showNip: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${parseLine(_chatConversation[index], 2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: ChatColors.whatsAppGreen),
                          ),
                          Text("${parseLine(_chatConversation[index], 3)}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Text(
                                      "${parseLine(_chatConversation[index], 0)}",
                                      style: TextStyle(fontSize: 9))),
                              Text("${parseLine(_chatConversation[index], 1)}",
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
}
