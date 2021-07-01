// import 'package:flutter/material.dart';
// import 'package:whatsapp_chat_viewer/providers/providers.dart';

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

// function for your chat object.
  //  fromMapObject(Map<String, dynamic> map) {
  //     this.date = map['date'];
  //     this.time = map['time'];
  //     this.name = map['name'];
  //     this.message = map['message'];
  //     this.fileAttached = map['fileAttached'];
  // }

  factory Chat.fromMapObject(Map<String, Object> map) {
    return Chat(
      date: map['date'],
      time: map['time'],
      name: map['name'],
      message: map['message'],
      fileAttached: map['fileAttached'],
    );
  }
}

class WCVImportFile {
  WCVImportFile({
    this.date,
    this.fileName,
    this.size,
    this.filePath,
    this.tableName,
  });

  String date; // from text file, do we need to store in DateTime object??
  String fileName;
  String size;
  String filePath;
  String tableName; // string or boolean??
}
