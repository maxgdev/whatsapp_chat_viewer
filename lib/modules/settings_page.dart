import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/model/chat_model.dart';
import 'chat_styles.dart';

class SettingsRoute extends StatefulWidget {
  SettingsRoute({Key key, this.userSettings}) : super(key: key);

  final UserSettings userSettings;

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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/whatsapp_wallpaper.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Enter your username as it appears in your chat',
                  style: ChatStyles.chatInputStyle1),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'UserName'),
                onChanged: (val) =>
                    setState(() => widget.userSettings.userName = val),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Default import file path: ${widget.userSettings.defaultImportPath}",
                style: ChatStyles.chatInputStyle1,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
