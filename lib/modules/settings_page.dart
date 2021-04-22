import 'package:flutter/material.dart';
import 'chat_colors.dart';

class SettingsRoute extends StatefulWidget {
  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  String userName = '';
  String defaultImportPath = '/storage/emulated/0/Download/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChatColors.whatsAppGreen,
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
              style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.bold)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'UserName'),             
                onChanged: (val) => setState(() => userName = val),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Default import file path: $defaultImportPath",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}
