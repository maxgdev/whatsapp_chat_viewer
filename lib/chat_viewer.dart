import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/chats.dart';
import 'package:whatsapp_chat_viewer/chat_colors.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ChatHomePage extends StatefulWidget {
  ChatHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  Directory rootPath;
  String filePath;
  String dirPath;
  FileTileSelectMode filePickerSelectMode = FileTileSelectMode.wholeTile;

  void initState() {
    super.initState();

    _prepareStorage();
  }

  Future<void> _prepareStorage() async {
    rootPath = await getTemporaryDirectory();

    // Create sample directory if not exists
    Directory sampleFolder = Directory('${rootPath.path}/Sample folder');
    if (!sampleFolder.existsSync()) {
      sampleFolder.createSync();
    }

    // Create sample file if not exists
    File sampleFile = File('${sampleFolder.path}/WhatsAppExport.txt');
    if (!sampleFile.existsSync()) {
      sampleFile.writeAsStringSync("12/11/2014, 12:22 PM - John: Hi Stacy");
      sampleFile
          .writeAsStringSync("13/11/2014, 8:10 AM - Stacy: yeah I am good");
    }

    setState(() {});
  }

  Future<void> _openFile(BuildContext context) async {
    String path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.file,
      // folderIconColor: Colors.teal,
      allowedExtensions: ['.txt'],
      // fileTileSelectMode: filePickerSelectMode,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
      requestPermission: () async =>
          await Permission.storage.request().isGranted,
    );

    if (path != null) {
      File file = File('$path');
      String contents = await file.readAsString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text(contents),
            duration: Duration(seconds: 3),
            // backgroundColor: ChatColors.whatsAppGreen,
            )
            
          );
    }
    print("Open file_picker to import text file");
    
    setState(() {
      filePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whatsAppGreen,
        title: Text(widget.title),
      ),
      body: Chats(),
      floatingActionButton: FloatingActionButton(
        onPressed: (rootPath != null) ? () => _openFile(context) : null,
        tooltip: 'Add Chat',
        backgroundColor: ChatColors.whatsAppGreen,
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
