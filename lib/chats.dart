import 'package:flutter/material.dart';
import './chat_colors.dart';

class Chats extends StatefulWidget {
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  
  List<String> names = [
    'Malcolm',
    'Shaka',
    'Diop',
    'Patrice',
    'Garvey',
    'Steve',
    'Anthony',
    'Nelson',
  ];

  List<String> text = [
    'Tellus ac semper cursus',
    'Lacus felis ullamcorper eros',
    'Nullam leo metus',
    'Donec ac ligula convallis',
    'Vivamus id arcu sed?',
    'Curabitur nec commodo',
    'Mauris sollicitudin porttitor',
    'Morbi ac velit metus',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ChatColors.whatsAppGreen,
          child: Center(
            child: Icon(Icons.message),
          ),
          onPressed: null),
      body: Container(
        child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      // backgroundImage: AssetImage('assets/images.contact.png'),
                      backgroundColor: ChatColors.whatsAppGreen,
                      // foregroundColor: Colors.white,
                    ),
                    title: Text(names[index]),
                    subtitle: Text(text[index]),
                    trailing: Text('22:50 PM'),
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
