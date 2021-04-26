import 'package:flutter/material.dart';
import 'chat_styles.dart';
import '../model/chat_model.dart';
import 'chat_details.dart';

class Chats extends StatefulWidget {
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  final List<Chat> chatsList = [
    Chat(
        date: "1/24/21",
        time: "11:27 AM",
        name: "Gates",
        message: "I am a meglomaniacal, genocidal racist billionare twat",
        fileAttached: ""),
    Chat(
        date: "1/24/21",
        time: "12:33 PM",
        name: "Malcolm",
        message: "Duis dapibus imperdiet tempus. Pellentesque rutrum a ex",
        fileAttached: ""),
    Chat(
        date: "1/24/21",
        time: "01:27 PM",
        name: "Anthony",
        message:
            "Aenean auctor fermentum dolor, sed hendrerit augue cursus eget",
        fileAttached: ""),
    Chat(
        date: "1/24/21",
        time: "03:01 PM",
        name: "Boris",
        message: "I am the biggest lying bullshiting Prime Minister ever",
        fileAttached: ""),
    Chat(
        date: "1/24/21",
        time: "02:27 PM",
        name: "Hancock",
        message: "Call me a COVID twat and dump me in the deepest hell prison",
        fileAttached: ""),
  ];
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
          itemCount: chatsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ChatStyles.whatsAppGreen,
                    // foregroundColor: Colors.white,
                    child: Text(chatsList[index].name[0]),
                  ),
                  title: Text(chatsList[index].name),
                  subtitle: Text(chatsList[index].message),
                  trailing: Text(chatsList[index].time),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailsScreen(),
                          settings: RouteSettings(arguments: chatsList[index]),
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
