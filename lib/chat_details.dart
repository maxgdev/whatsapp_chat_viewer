import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_chat_viewer/chat_model.dart';
import 'chat_colors.dart';
import 'package:bubble/bubble.dart';

class ChatDetailScreen extends StatelessWidget {
  // var myText;

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

   parseLine(String txtLine, int index) {
    var dateToken, restToken, nameToken, textToken;
    var tokenList;
    dateToken = txtLine.split("-")[0];
    restToken = txtLine.split("-")[1];
    nameToken = restToken.split(":")[0];
    textToken = restToken.split(":")[1];
    tokenList = [dateToken, nameToken, textToken];
    return tokenList[index];
  }

  // String fileText = await rootBundle.loadString('assets/avengers.txt');
  Future<String> getFile() async {
    String importTxt = await rootBundle.loadString('assets/avengers.txt');
    print(importTxt);
    return importTxt;
  }

  @override
  Widget build(BuildContext context) {
    //
    final Chat chat = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
        backgroundColor: ChatColors.whatsAppGreen,
      ),
      body: Container(
        // color: Colors.yellow.withAlpha(64),
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Bubble(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 212, 234, 244),
              borderColor: Colors.black,
              borderWidth: 2,
              margin: BubbleEdges.only(top: 8),
              child: Text(
                'TODAY',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Bubble(
              style: styleSomebody,
              child: Text(
                  'Hi Jason. Sorry to bother you. I have a queston for you.'),
            ),
            Bubble(
              style: styleMe,
              child: Text("Whats'up?"),
            ),
            Bubble(
              style: styleSomebody,
              child: Text("I've been having a problem with my computer."),
            ),
            Bubble(
              style: styleSomebody,
              margin: BubbleEdges.only(top: 4),
              showNip: false,
              child: Text('Can you help me?'),
            ),
            Bubble(
              style: styleMe,
              child: Text('Ok'),
            ),
            Bubble(
              style: styleMe,
              showNip: false,
              margin: BubbleEdges.only(top: 4),
              child: Text("What's the problem?"),
            ),
            Divider(),
            Bubble(
              margin: BubbleEdges.only(top: 5),
              elevation: 10,
              shadowColor: Colors.red[900],
              alignment: Alignment.topRight,
              nip: BubbleNip.rightBottom,
              color: Colors.green,
              child: Text('dsfdfdfg'),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("This is a single line from the imported text file:"),
                Text("13/11/2014, 8:10 AM - Stacy: yeah I am good"),
                Divider(),
                Text("This is the format: <time stamp> – <name>: <text> "),
                Divider(),
                Text(
                    "This <time stamp> : ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 0)}"),
                Text(
                    "This <name>: ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 1)} "),
                Text(
                    "This <text>:  ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 2)}"),
              ],
            ),
            Bubble(
              style: styleMe,
              showNip: false,
              margin: BubbleEdges.only(top: 4),
              child: Text("text"),
            ),
          ],
        ),
      ),
    );
  }
}
