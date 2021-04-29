import 'package:flutter/material.dart';

class Chat {
  Chat({
    this.date,
    this.time,
    this.name,
    this.message,
    this.fileAttached,
  });

  String date; // from text file, do we need to store in DateTime object??
  String time; // from text file, do we need to store in DateTime object??
  String name;
  String message;
  String fileAttached; // string or boolean??
}

class WCVImportFile {
  WCVImportFile({
    this.date,
    this.fileName,
    this.size,
    this.filePath,
    this.fileAttached,
  });

  String date; // from text file, do we need to store in DateTime object??
  String fileName;
  String size;
  String filePath;
  String fileAttached; // string or boolean??
}

// class Conversation {
//   Conversation({
//     this.id,
//     this.fileName,
//     this.chatList,

//   });

//   int id;
//   String fileName;
//   String chatList;
// }
//
class UserSettings {
  UserSettings({
    this.userName,
    this.defaultImportPath,
  });

  // from text file, do we need to store in DateTime object??
  String userName;
  String defaultImportPath;
}

class SetUser with ChangeNotifier {
  String name = "";
  String defaultImportPath = '/data/user/0/com.example.whatsapp_chat_viewer/';
  
  void changeName(val) {
    name = val;
    print(name);
    notifyListeners();
  }
}
