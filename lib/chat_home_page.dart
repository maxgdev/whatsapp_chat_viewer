import 'package:flutter/material.dart';
// import 'package:whatsapp_chat_viewer/chats.dart';
import 'package:whatsapp_chat_viewer/chat_colors.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'file_list.dart';
import 'chat_model.dart';

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

  final List<WCVImportFile> fileList = [
    WCVImportFile(
        date: "1/24/21",
        fileName: "WhatsApp Chat 1/24/21.txt",
        size: "45Kb",
        filePath: "",
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "John & Sam Chat 1/24/21.txt",
        size: "180Kb",
        filePath: "",
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "Avengers.txt",
        size: "45Kb",
        filePath: "",
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21",
        fileName: "ChatExport.txt",
        size: "99Kb",
        filePath: "",
        fileAttached: ""),
    WCVImportFile(
        date: "1/24/21", 
        fileName: "Test.txt", 
        size: "5Kb", 
        filePath: "",
        fileAttached: ""),
  ];
  void initState() {
    super.initState();

    _prepareStorage();
  }

  Future<void> _prepareStorage() async {
    rootPath = await getTemporaryDirectory();

    // Create sample directory if not exists
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
      String contents = await file.readAsString();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(contents),
        duration: Duration(seconds: 3),
        // backgroundColor: ChatColors.whatsAppGreen,
      ));
      importedFile = file;
      print("file: $file");
      importedFileName = p.basename('$importedFile');
      // get file size
      importedFileSize = (await File(path).readAsBytes()).length;
      // importedFileSize = file.lengthSync(); // alternative
      // importedFileSize = await file.length(); //
      final stat = FileStat.statSync("$importedFile");
      print("Last access: ${stat.accessed}, Last modifiied: ${stat.modified} ");
      print("--------- Imported File Stats ------------");
      print("Filename: $importedFileName, filesize: $importedFileSize");
      // Create file object to add to ileList
      var fileObject = WCVImportFile(
          date: "1/24/21",
          fileName: p.basename('$importedFile'),
          size: "$importedFileSize bytes",
          filePath: "$file",
          fileAttached: "");
      fileList.add(fileObject);
    }
    print("Open file_picker to import text file");
    // print(importedFile);
    // process lines of file
    importedFile
        .readAsLines()
        .then(processLines)
        .catchError((err) => handleError(err));

    setState(() {
      filePath = path;
    });
  } // _openFile()

  processLines(List<String> lines) {
    // process lines:
    for (var line in lines) {
      print(line);
    }
  }

  handleError(e) {
    print("An error...: $e");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whatsAppGreen,
        title: Text(widget.title),
      ),
      // body: Chats(),
      body: WCVImportFileList(fileList),
      floatingActionButton: FloatingActionButton(
        onPressed: (rootPath != null) ? () => _openFile(context) : null,
        tooltip: 'Add Chat',
        backgroundColor: ChatColors.whatsAppGreen,
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
