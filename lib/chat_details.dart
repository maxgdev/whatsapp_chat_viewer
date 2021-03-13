import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_chat_viewer/chat_model.dart';
import 'chat_colors.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';
import 'dart:convert';
import './parse_line.dart';

class ChatDetailsScreen extends StatefulWidget {
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  // _chatConversation scoped to function
  List<String> _chatConversation = [];

  Future<List<String>> _loadChatConversation() async {
    // chatConversation scoped to inner function
    List<String> chatConversation = [];
    await rootBundle.loadString('assets/chatsample.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        chatConversation.add(i);
      }
    });
    return chatConversation;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> chatConversation = await _loadChatConversation();

    // Notify the UI and display the questions
    setState(() {
      _chatConversation = chatConversation;
    });
  }

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

  // parseLine(String txtLine, int index) {
  //   var dateToken, restToken, nameToken, textToken;
  //   var tokenList;
  //   dateToken = txtLine.split("-")[0];
  //   restToken = txtLine.split("-")[1];
  //   nameToken = restToken.split(":")[0];
  //   textToken = restToken.split(":")[1];
  //   tokenList = [dateToken, nameToken, textToken];
  //   return tokenList[index];
  // }

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
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //         "This <time stamp> : ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 0)}"),
            //     Text(
            //         "This <name>: ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 1)} "),
            //     Text(
            //         "This <text>:  ${parseLine('13/11/2014, 8:10 AM - Stacy: yeah I am good', 2)}"),
            //   ],
            // ),
            Container(
              height: 600,
              child: ListView.builder(
                itemCount: _chatConversation.length,
                itemBuilder: (context, index) {
                  // return Text(_chatConversation[index]);
                  return  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: ChatColors.whatsAppGreen,
                        // foregroundColor: Colors.white,
                        // child: Text(_chatConversation[index][0]),
                        child: Text("${parseLine(_chatConversation[index], 1)[1]}"),
                      ),
                      Expanded(
                        child: Bubble(
                          style: styleSomebody,
                          margin: BubbleEdges.only(top: 4),
                          showNip: true,
                          child: Text(_chatConversation[index]
                            // "${parseLine(_chatConversation[index], 0)}" 
                            // "${parseLine(_chatConversation[index], 2)}"
                            ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
