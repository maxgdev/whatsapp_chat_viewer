import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/importFile.txt');
  }

  // 'assets/avengers.txt'
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/avengers.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  // Future<List> readLines() async {
  //   try {
  //     final file = await _localFile;
  //     // final file = await rootBundle.loadString('assets/avengers.txt');
  //     // Read the file
  //     List contents = await file.readAsLines();
  //     var numberOfLines = contents.length;
  //     print(numberOfLines);
  //     return contents;
  //   } catch (e) {
  //     // If encountering an error, return 0
  //     return [];
  //   }
  // }

  Future<String> readLines() async {
    String text;
    try {
      // final Directory directory = await getApplicationDocumentsDirectory();
      // final File file = File('${directory.path}/assets/avengers.txt');
      final File file = File('/assets/avengers.txt');
      text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}

void readFileAsync() {
  File('assets/avengers.txt').readAsString().then((c) => print(c));
}

//  parseLine(String txtLine, int index) {
//   var dateToken, restToken, nameToken, textToken;
//   var tokenList;
//   dateToken = txtLine.split("-")[0];
//   restToken = txtLine.split("-")[1];
//   nameToken = restToken.split(":")[0];
//   textToken = restToken.split(":")[1];
//   tokenList = [dateToken, nameToken, textToken];
//   return tokenList[index];
// }

// Future<String> getFile() async {
//   String importTxt = await rootBundle.loadString('assets/avengers.txt');
//   print(importTxt);
//   return importTxt;
// }

class FlutterDemo extends StatefulWidget {
  final CounterStorage storage;

  FlutterDemo({Key key, @required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String _addText;
  int numberOfLines;
  List _noLines;
  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String value) {
      setState(() {
        _addText = value;
        readFileAsync();
      });
    });

    widget.storage.readLines().then((value) {
      setState(() {
        // numberOfLines = value.length;
        // _addText = value;
      });
    });
    // print(numberOfLines);
  }

  Future<File> _incrementCounter() {
    setState(() {
      _addText = '13/11/2014, 8:10 AM - Stacy: yeah I am good\n';
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_addText);
  }

  // test() {
  //   print(_noLines);
  //   return _noLines.length;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Column(
          children: [
            Text(
              'Chat Added: $_addText }',
            ),
            // Text('Number of Lines: ${test()}'),
            // Text(_noLines),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add Chat',
        child: Icon(Icons.add),
      ),
    );
  }
}
