import 'package:flutter/material.dart';
import './chat_colors.dart';

import './chat_details.dart';

class WCVImportFileList extends StatefulWidget {
  WCVImportFileList(this.fileList);

  final List fileList;

  WCVImportFileListState createState() => WCVImportFileListState();
}

class WCVImportFileListState extends State<WCVImportFileList> {

  // final List<WCVImportFile> fileList = [

  //   WCVImportFile(
  //       date: "1/24/21",
  //       fileName: "WhatsApp Chat 1/24/21.txt",
  //       size:"45Kb",
  //       fileAttached: ""),
  //   WCVImportFile(
  //       date: "1/24/21",
  //       fileName: "John & Sam Chat 1/24/21.txt",
  //       size:"180Kb",
  //       fileAttached: ""),
  //   WCVImportFile(
  //       date: "1/24/21",
  //       fileName: "Avengers.txt",
  //       size:"45Kb",
  //       fileAttached: ""),
  //   WCVImportFile(
  //       date: "1/24/21",
  //       fileName: "ChatExport.txt",
  //       size:"99Kb",
  //       fileAttached: ""),
  //   WCVImportFile(
  //       date: "1/24/21",
  //       fileName: "Test.txt",
  //       size:"5Kb",
  //       fileAttached: ""),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/whatsapp_wallpaper.png"),
              fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: widget.fileList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ChatColors.whatsAppGreen,
                    // foregroundColor: Colors.white,
                    child: Text(widget.fileList[index].fileName[0]),
                  ),
                  title: Text(widget.fileList[index].fileName),
                  // subtitle: Text(widget.fileList[index].size),
                  subtitle: Text("${widget.fileList[index].filePath}"),
                  trailing: Text(widget.fileList[index].date),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailsScreen(),
                          settings: RouteSettings(arguments: widget.fileList[index]),
                        ));
                  },
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
