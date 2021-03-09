import 'package:flutter/material.dart';
import './chat_colors.dart';
import 'chat_model.dart';
import './chat_details.dart';

class Chats extends StatefulWidget {
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  // List<String> names = [
  //   'Malcolm',
  //   'Shaka',
  //   'Diop',
  //   'Patrice',
  //   'Garvey',
  //   'Steve',
  //   'Anthony',
  //   'Nelson',
  // ];

  // List<String> text = [
  //   'Tellus ac semper cursus',
  //   'Lacus felis ullamcorper eros',
  //   'Nullam leo metus',
  //   'Donec ac ligula convallis',
  //   'Vivamus id arcu sed?',
  //   'Curabitur nec commodo',
  //   'Mauris sollicitudin porttitor',
  //   'Morbi ac velit metus',
  // ];

  // Generate List of 10 Chat Objects in chatsList
  final chatsList = List<Chat>.generate(
      10,
      (index) => Chat(
          date: "1/24/21",
          time: "11:27 AM",
          name: "Malcolm",
          message: "Praesent ut malesuada nulla. Nunc a sapien vitae sem",
          fileAttached: ""));

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
          itemCount: chatsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  
                  leading: CircleAvatar(
                    backgroundColor: ChatColors.whatsAppGreen,
                    // foregroundColor: Colors.white,
                  ),
                  title: Text(chatsList[index].name),
                  subtitle: Text(chatsList[index].message),
                  trailing: Text(chatsList[index].time),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            ChatDetailScreen(),
                          settings: RouteSettings(
                            arguments: chatsList[index]
                          ),
                            
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
