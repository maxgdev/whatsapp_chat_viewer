import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/modules/chat_styles.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/chat_model.dart';
import '../providers/providers.dart';
import 'settings_page.dart';
import 'file_list.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

    // print(rootPath);
    // print(rootPath.path);
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
      allowedExtensions: ['.txt'],
      fileTileSelectMode: FileTileSelectMode.wholeTile,
      requestPermission: () async =>
          await Permission.storage.request().isGranted,
    );

    if (path != null) {
      File file = File('$path');
      // String contents = await file.readAsString();

      importedFile = file;
      importedFileName = importedFile.path.split('/').last;
      // get file size
      importedFileSize = (await File(path).readAsBytes()).length;
      // importedFileSize = file.lengthSync();    // alternative
      // importedFileSize = await file.length();  // alternative

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   // content: Text(contents),
      //   content: Text(importedFileName),
      //   duration: Duration(seconds: 3),
      //   // backgroundColor: ChatColors.whatsAppGreen,
      // ));

      final stat = FileStat.statSync("$importedFile");
      var modifiedTime = DateFormat('dd/MM/yy').format(stat.modified);
   
      print("--------- Imported File Stats ------------");
      print("Filename: $importedFileName, filesize: $importedFileSize");

      // Create file object to add to fileList
      var fileObject = WCVImportFile(
          date: "$modifiedTime",
          fileName: '$importedFileName',
          size: "$importedFileSize bytes",
          filePath: file.path,
          fileAttached: "");
      Provider.of<ImportedChats>(context, listen: false)
          .addImportedChats(fileObject);
      // fileList.add(fileObject);
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
    final userSettings = Provider.of<UserSettings>(context);
    final fileList = Provider.of<ImportedChats>(context).fileList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatStyles.whatsAppGreen,
        title: Text(widget.title),
        actions: [settingsIconBtn(userSettings)],
      ),
      body: WCVImportFileList(fileList),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: (rootPath != null) ? () => _openFile(context) : null,
        tooltip: 'Add Chat',
        backgroundColor: ChatStyles.whatsAppGreen,
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget settingsIconBtn(userSettings) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SettingsRoute(userSettings: userSettings)),
        );
      },
    );
  }
}
