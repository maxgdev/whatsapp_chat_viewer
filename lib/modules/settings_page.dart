import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/model/chat_model.dart';
import 'chat_styles.dart';
import 'package:provider/provider.dart';

class SettingsRoute extends StatefulWidget {
  SettingsRoute({Key key, this.userSettings}) : super(key: key);

  final SetUser userSettings;

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatStyles.whatsAppGreen,
        title: Text("Settings"),
      ),
      body: Container(
        decoration: ChatStyles.containerBackgroundImage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Enter your name as it appears in your chat',
                  style: ChatStyles.chatInputStyle0
              )    
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Consumer<SetUser>(
                builder: (context, setuser, child) => TextFormField(
                    decoration: InputDecoration(labelText: setuser.name),
                    onChanged: (val) => setuser.changeName(val)
                  ),
              ),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Default import file path: ",
                      style: ChatStyles.chatInputStyle1,
                      ),
                  Text(
                  " ${widget.userSettings.defaultImportPath}",
                    style: ChatStyles.chatInputStyle2,)
                ],
              ),
            ),
      
            Divider(),
          ],
        ),
      ),
    );
  }
}
