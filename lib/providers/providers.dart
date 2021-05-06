import 'package:flutter/material.dart';
import '../model/chat_model.dart';
import '../modules/parse_utils.dart';
import 'dart:async';
import 'dart:io';

class UserSettings with ChangeNotifier {
  String name = "";
  String defaultImportPath = '/data/user/0/com.example.whatsapp_chat_viewer/';

  void changeName(val) {
    name = val;
    print(name);
    notifyListeners();
  }
}

class ImportedChats with ChangeNotifier {
  List fileList = [
    WCVImportFile(
        date: "24/01/21",
        fileName: "WhatsApp Chat 1/24/21.txt",
        size: "45Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/WhatsApp Chat with Sam 2.txt',
        fileAttached: ""),
    WCVImportFile(
        date: "24/01/21",
        fileName: "John & Sam Chat 1/24/21.txt",
        size: "180Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/WhatsAppExport.txt',
        fileAttached: ""),
    WCVImportFile(
        date: "24/01/21",
        fileName: "ChatExport.txt",
        size: "99Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/ChatExport.txt',
        fileAttached: ""),
  ];

  void deleteImportedChats(List fileList, int index) {
    fileList.removeAt(index);
    notifyListeners();
  }

  void addImportedChats(WCVImportFile fileObject) {
    fileList.add(fileObject);
    notifyListeners();
  }
}

class ChatConversations with ChangeNotifier {
  
  // List<Chat> _chatConversation = [];

  List<Chat> _chatConversation =  [
    Chat(
      date: "12/11/2014",
      time:"12:22",
      name:"John",
      message:"Hi Stacy",
      fileAttached: "",
    ),
        Chat(
      date: "12/11/2014",
      time:"12:22",
      name:"John",
      message:"Here are the details for tomorrow's picnic. The park is located at 123 Main Street. Bring your own snacks, we will also be grilling. It is going to be very warm so dress appropriately. We should be getting there at noon. See you then and don't forget the sunscreen.",
      fileAttached: "",
    ),
        Chat(
      date: "13/11/2014",
      time:"8:09",
      name:"Stacy",
      message:"yeah I am good",
      fileAttached: "",
    ),
        Chat(
      date: "12/11/2014,",
      time:"12:22",
      name:"Stacy",
      message:"and home too",
      fileAttached: "",
    ),
  ];
  // WCVImportFile wcvObject;

  List get chatConversation => _chatConversation;

  setup(WCVImportFile wcvObject) async {
    // List<String> chatConversation =
    //     await _loadImportedChatConversation(widget.wcvObject);
    List<String> tempChatConversation = await fileToChatObject(wcvObject);
   return tempChatConversation;

  }


  void readConversations(wcvObject) {
    // read from list/
    // List<String> chatConversation = _loadImportedChatConversation(wcvObject);
    // _chatConversation = convertToChatObjects(chatConversation);

    // List<String> chatC1 =
    //     await _loadImportedChatConversation(wcvObject);

    // List<String> chatC2 =
    //     await fileToChatObject(wcvObject);


    // )

    // Now batch insert chats as rows

    // print(widget.wcvObject.fileName);
    // var tableName = formatFilename(widget.wcvObject.fileName);
    // var results =
    //     await DatabaseHelper.instance.batchInsert(tableName, _chatConversation);
    // print("results: $results");

    // query all rows of table
    // var myQuery = await DatabaseHelper.instance.queryRowCount();
    // print(myQuery);
  

    notifyListeners();
  }

  void writeConversations(chatConversation) {
    // write to list/db_table
    notifyListeners();
  }
}
