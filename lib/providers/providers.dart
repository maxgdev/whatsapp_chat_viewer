import 'package:flutter/material.dart';
import '../model/chat_model.dart';

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