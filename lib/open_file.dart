// https://stackoverflow.com/questions/60239587/how-can-i-read-text-from-files-and-display-them-as-list-using-widget-s-in-flutte
//
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadConversation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadConversationState();
  }
}

class LoadConversationState extends State<LoadConversation> {
  // _chatConversation scoped to function
  List<String> _chatConversation = [];

  Future<List<String>> _loadChatConversation() async {
    // chatConversation scoped to inner function
    List<String> chatConversation = [];
    await rootBundle.loadString('assets/avengers.txt').then((q) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _chatConversation.length,
        itemBuilder: (context, index) {
          return Text(_chatConversation[index]);
        },
      ),
    );
  }
}
