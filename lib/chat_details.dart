import 'package:flutter/material.dart';
import 'package:whatsapp_chat_viewer/chat_model.dart';
import 'chat_colors.dart';
import 'package:bubble/bubble.dart';

class ChatDetailScreen extends StatelessWidget {
  static const styleSomebody = BubbleStyle(
    // nip: BubbleNip.leftCenter,
    nip: BubbleNip.leftBottom,
    color: Colors.white,
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    // nip: BubbleNip.rightCenter,
    nip: BubbleNip.rightBottom,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );
  @override
  Widget build(BuildContext context) {
    //
    final Chat chat = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
        backgroundColor: ChatColors.whatsAppGreen,
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Container(
      //     child: ListTile(
      //       title: Text(chat.name),
      //       subtitle: Text(chat.message),
      //       trailing: Text(chat.time),
      //     ),
      //   ),
      // ),
      body: Container(
        // color: Colors.yellow.withAlpha(64),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Bubble(
              alignment: Alignment.center,
              color: const Color.fromARGB(255, 212, 234, 244),
              borderColor: Colors.black,
              borderWidth: 2,
              margin: const BubbleEdges.only(top: 8),
              child: const Text(
                'TODAY',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Bubble(
              style: styleSomebody,
              child: const Text(
                  'Hi Jason. Sorry to bother you. I have a queston for you.'),
            ),
            Bubble(
              style: styleMe,
              child: const Text("Whats'up?"),
            ),
            Bubble(
              style: styleSomebody,
              child: const Text("I've been having a problem with my computer."),
            ),
            Bubble(
              style: styleSomebody,
              margin: const BubbleEdges.only(top: 4),
              showNip: false,
              child: const Text('Can you help me?'),
            ),
            Bubble(
              style: styleMe,
              child: const Text('Ok'),
            ),
            Bubble(
              style: styleMe,
              showNip: false,
              margin: const BubbleEdges.only(top: 4),
              child: const Text("What's the problem?"),
            ),
            const Divider(),
            Bubble(
              margin: const BubbleEdges.only(top: 5),
              elevation: 10,
              shadowColor: Colors.red[900],
              alignment: Alignment.topRight,
              nip: BubbleNip.rightBottom,
              color: Colors.green,
              child: const Text('dsfdfdfg'),
            )
          ],
        ),
      ),
    );
  }
}
