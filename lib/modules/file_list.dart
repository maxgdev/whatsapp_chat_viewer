import 'package:flutter/material.dart';
import 'chat_styles.dart';
import 'chat_details.dart';

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
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ChatStyles.whatsAppGreen,
                    child: Text(widget.fileList[index].fileName[0]),
                  ),
                  title: Text(widget.fileList[index].fileName),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Size: ${widget.fileList[index].size}"),
                      Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),),
                      Text(" Date: ${widget.fileList[index].date}"),
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        print("${widget.fileList[index].fileName} deleted!");
                      }),
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => ChatDetailsScreen(
                        wcvObject: widget.fileList[index],
                      ),
                    );
                    Navigator.of(context).push(route);
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
