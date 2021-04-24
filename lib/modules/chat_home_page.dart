import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/modules/chat_colors.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'file_list.dart';
import '../model/chat_model.dart';
import 'settings_page.dart';

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
  File importedFile;
  String importedFileName;
  int importedFileSize;
  // retain userName for chatdetails screen

  final userSettings = UserSettings(
    userName: '',
    defaultImportPath: '/data/user/0/com.example.whatsapp_chat_viewer/',
  );

  final List<WCVImportFile> fileList = [
    WCVImportFile(
        date: "1/24/21",
        fileName: "WhatsApp Chat 1/24/21.txt",
        size: "45Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/cache/Sample folder/WhatsApp Chat with Sam 2.txt',
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "John & Sam Chat 1/24/21.txt",
        size: "180Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/cache/Sample folder/WhatsAppExport.txt',
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "ChatExport.txt",
        size: "99Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/cache/Sample folder/ChatExport.txt',
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "Test.txt",
        size: "5Kb",
        filePath:
            '/data/user/0/com.example.whatsapp_chat_viewer/cache/Sample folder/WhatsAppExport.txt',
        fileAttached: ""),
  ];
  void initState() {
    super.initState();

    _prepareStorage();
  }

  Future<void> _prepareStorage() async {
   
    // rootPath = await getExternalStorageDirectory();
    rootPath = await getApplicationDocumentsDirectory();
    // rootPath = await getApplicationSupportDirectory();
    // rootPath = Directory('/storage/emulated/0/Download/');

    // Create sample directory if not exist
    // Directory sampleFolder = Directory('${rootPath.path}/Sample folder');
    Directory sampleFolder = Directory('${rootPath.path}/Sample folder');

    print(rootPath);
    print(rootPath.path);
    if (!sampleFolder.existsSync()) {
      sampleFolder.createSync();
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
      // String contents = await file.readAsString();

      importedFile = file;
      importedFileName = importedFile.path.split('/').last;

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   // content: Text(contents),

      //   content: Text(importedFileName),
      //   duration: Duration(seconds: 3),
      //   // backgroundColor: ChatColors.whatsAppGreen,
      // ));

      // get file size
      importedFileSize = (await File(path).readAsBytes()).length;
      // importedFileSize = file.lengthSync(); // alternative
      // importedFileSize = await file.length(); //
      final stat = FileStat.statSync("$importedFile");
      print("Last access: ${stat.accessed}, Last modifiied: ${stat.modified} ");
      print("--------- Imported File Stats ------------");
      print("Filename: $importedFileName, filesize: $importedFileSize");
      // Create file object to add to fileList
      var fileObject = WCVImportFile(
          date: "1/24/21",
          fileName: '$importedFileName',
          size: "$importedFileSize bytes",
          filePath: file.path,
          fileAttached: "");
      fileList.add(fileObject);
    }

    setState(() {
      filePath = path;
    });
  } // _openFile()

  // processLines(List<String> lines) {
  //   // process lines:
  //   // for (var line in lines) {
  //   //   print(line);
  //   // }
  // }

  // handleError(e) {
  //   print("An error...: $e");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whatsAppGreen,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsRoute(userSettings: userSettings)),
              );
            },
          ),
        ],
      ),
      // body: Chats(),
      body: WCVImportFileList(fileList),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: (rootPath != null) ? () => _openFile(context) : null,
        tooltip: 'Add Chat',
        backgroundColor: ChatColors.whatsAppGreen,
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
