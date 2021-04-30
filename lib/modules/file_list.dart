import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/model/chat_model.dart';
import 'chat_styles.dart';
import 'chat_details.dart';
import 'package:provider/provider.dart';

class WCVImportFileList extends StatefulWidget {
  WCVImportFileList(this.fileList);

  final List fileList;

  WCVImportFileListState createState() => WCVImportFileListState();
}

class WCVImportFileListState extends State<WCVImportFileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ChatStyles.containerBackgroundImage,
        child: ListView.builder(
          itemCount: widget.fileList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                fileListWidget(widget.fileList, index),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget fileListWidget(List fileList, index) {
    return Consumer<ImportedChats>(
        builder: (context, importedChats, child) => ListTile(
              leading: CircleAvatar(
                backgroundColor: ChatStyles.whatsAppGreen,
                child: Text(fileList[index].fileName[0]),
              ),
              title: Text(fileList[index].fileName),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Size: ${fileList[index].size}"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ),
                  Text(" Date: ${fileList[index].date}"),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    importedChats.deleteImportedChats(fileList, index);
                    print("${fileList[index].fileName} deleted!");
           
                  }),
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => ChatDetailsScreen(
                    wcvObject: fileList[index],
                  ),
                );
                Navigator.of(context).push(route);
              },
            ));
  }

}
