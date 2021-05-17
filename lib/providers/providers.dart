import 'package:flutter/material.dart';
import '../model/chat_model.dart';
import '../modules/parse_utils.dart';
import '../modules/db_methods.dart';
// import 'dart:async';
// import 'dart:io';

class UserSettings with ChangeNotifier {
  // set default to John in development mode
  String name = "John";
  String defaultImportPath = '/data/user/0/com.example.whatsapp_chat_viewer/';

  void changeName(val) {
    name = val;
    print(name);
    notifyListeners();
  }
}

class ImportedChats with ChangeNotifier {
  List fileList = [];
  // List fileList = [
  //   WCVImportFile(
  //       date: "24/01/21",
  //       fileName: "WhatsApp Chat 1/24/21.txt",
  //       size: "45Kb",
  //       filePath:
  //           '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/WhatsApp Chat with Sam 2.txt',
  //       tableName: ""),
  //   WCVImportFile(
  //       date: "24/01/21",
  //       fileName: "John & Sam Chat 1/24/21.txt",
  //       size: "180Kb",
  //       filePath:
  //           '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/WhatsAppExport.txt',
  //       tableName: ""),
  //   WCVImportFile(
  //       date: "24/01/21",
  //       fileName: "ChatExport.txt",
  //       size: "99Kb",
  //       filePath:
  //           '/data/user/0/com.example.whatsapp_chat_viewer/Sample folder/ChatExport.txt',
  //       tableName: ""),
  // ];

  void deleteImportedChats(List fileList, int index) {
    var tempObj = fileList[index];
    fileList.removeAt(index);
    // Use fileList and index to get tableName and drop table
    DatabaseHelper.instance.dropTable(tempObj.tableName);
    notifyListeners();

  }

  void addImportedChats(WCVImportFile fileObject) {
    fileList.add(fileObject);
    notifyListeners();
  }
}

class ChatConversations with ChangeNotifier {
  List<Chat> _chatConversation = [];

  WCVImportFile wcvObject;

  List get chatConversation => [..._chatConversation];

  conversationLength(tableName) {
    var len;
    if (_chatConversation == []) {
      len = DatabaseHelper.instance.queryRowCount(tableName);
    }
    // len = _chatConversation.length;
    len = DatabaseHelper.instance.queryRowCount(tableName);
    print("[providers]: conversationLength(tableName) $len ");
    return len;
  }

  Future<List> readChatsFromDb(tableName) async {
    var myQuery = await DatabaseHelper.instance.queryTable(tableName);
    print("[providers]: queryTable: $myQuery ");
    print("[providers]:myQuery.length: ${myQuery.length}");

    // var myQuery2 = await DatabaseHelper.instance.queryRowCount(tableName);
    // print("[providers]:$tableName: $myQuery2");

    return myQuery;
  }

  Future<void> chatFromDb(tableName) async {
    // var myQuery = await DatabaseHelper.instance.queryRowCount(tableName);
    // print("[chat_home_page]: ===============================");
    // print("[chat_home_page]: myQuery count:==> $myQuery");

    // query all rows of table
    // querry results just inserted into Db
    var chatResults = await DatabaseHelper.instance.queryTable(tableName);
    _chatConversation = [];
    chatResults.forEach((itemMap) {
      _chatConversation.add(Chat.fromMapObject(itemMap));
    });
    notifyListeners();
    // print("[chat_home_page]: ===============================");
    // print("[chat_home_page]: _chatConversation:==> $_chatConversation");
    // print(_chatConversation.length);
    // return _chatConversation;
  }
}
