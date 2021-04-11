import '../model/chat_model.dart';
// Function to parse line string fronm text fiile
// parseLine(String txtLine, int index) {
//   var tempToken, dateToken, timeToken, restToken, nameToken, textToken;
//   var tokenList;
//   tempToken = txtLine.split("-")[0];
//   dateToken = tempToken.split(",")[0];
//   timeToken = tempToken.split(",")[1];

//   restToken =
//       (txtLine.split("-")[1].toString() != null) ? txtLine.split("-")[1] : "";

//   nameToken = (restToken.split(":")[0] != null)
//       ? nameToken = restToken.split(":")[0]
//       : "";
//   textToken = (restToken.split(":")[1] != null) ? restToken.split(":")[1] : "";
//   tokenList = [dateToken, timeToken, nameToken, textToken];
//   // 0 dateToken, 1 timeToken, 2 nameToken, 3 textToken
//   return tokenList[index];
// }

regexParseLine(String txtLine) {
  // RegExp lineExp =  RegExp("([0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s(AM|PM\s-\s([a-zA-Z]*):))", caseSensitive: false, multiLine: false);
  // Match line with dd/mm/yy, hh:mm - ONLY
  // RegExp lineExp = RegExp(r"^([0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s)",
  //     caseSensitive: false, multiLine: false);

  RegExp lineExp = RegExp(
      r"([0-9]?[0-9]\/[0-9][0-9]\/[0-9]{4}),\s([0-9]?[0-9]:[0-9][0-9])",
      caseSensitive: false,
      multiLine: false);
  // tempToken = tempToken.group(0) = 13/11/2014, 8:10
  // dateToken = tempToken.group(1) = 13/11/2014
  // timeToken = tempToken.group(2) = 8:10

  RegExp lineExp2 = RegExp(
      r"([0-9]?[0-9]\/[0-9][0-9]\/[0-9]{4}),\s([0-9]?[0-9]:[0-9][0-9])\s(AM|PM)?\s?-\s(.*)",
      caseSensitive: false,
      multiLine: false);
  // tempToken = tempToken.group(0) = 13/11/2014, 8:10 AM - Stacy: yeah I am good
  // dateToken = tempToken.group(1) = 13/11/2014
  // timeToken = tempToken.group(2) = 8:10
  // temp3Token =tempToken.group(3) = AM
  // nameToken/restToken = tempToken.group(4) = Stacy: yeah I am good

  // Match line with dd/mm/yy, hh:mm - <name>:
  RegExp chatLineExp = RegExp(
      r"([0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s(AM|PM\s-\s([a-zA-Z]*):))\s");

  // DATE, TIME - NAME : TEXT
  var tempToken, dateToken, timeToken, restToken, nameToken, textToken;
  var temp2Token, temp3Token;
  var tokenList;
  tempToken = lineExp2.firstMatch(txtLine);
  // tempToken = chatLineExp.firstMatch(txtLine);

  if (tempToken != null) {
    // tempToken.group(0) matches EVERYTHING??
    temp2Token = tempToken.group(0);
    dateToken = tempToken.group(1);
    timeToken = tempToken.group(2);
    temp3Token = tempToken.group(3);
    nameToken = tempToken.group(4);
    // textToken = tempToken.group(5);
    // restToken = tempToken.group(6);
    tokenList = [
      temp2Token,
      dateToken,
      timeToken,
      temp3Token,
      nameToken,
      textToken,
      restToken
    ];
  }

  print("regexParseLine running...");

  // Expectation: true
  if (tempToken != null) {
    // if (chatLineExp.hasMatch(txtLine)) {
    print('Line 1 is valid');

    print("tempToken = tempToken.group(0) = ${tempToken.group(0)}");
    print("dateToken = tempToken.group(1) = ${tempToken.group(1)}");
    print("timeToken = tempToken.group(2) = ${tempToken.group(2)}");
    print("temp3Token =tempToken.group(3) = ${tempToken.group(3)}");
    print("nameToken = tempToken.group(4) = ${tempToken.group(4)}");
    // print("textToken = tempToken.group(5) = ${tempToken.group(5)}");
    // print("restToken = tempToken.group(6) = ${tempToken.group(6)}");
    // print("tempToken.group(7) = ${tempToken.group(7)}");
    //  print("tempToken.group(7) = ${tempToken.group(8)}");
  }
}

//-----------------------------------------
regexP(String txtLine) {
  RegExp lineExp = RegExp(
      r"([0-9]?[0-9]\/[0-9]?[0-9]\/[0-9]{2,4}),\s([0-9]?[0-9]:[0-9][0-9])\s(AM|PM)?\s?-\s(.*)",
      caseSensitive: false,
      multiLine: false);
  // tempToken = tempToken.group(0) = 13/11/2014, 8:10 AM - Stacy: yeah I am good
  // dateToken = tempToken.group(1) = 13/11/2014
  // timeToken = tempToken.group(2) = 8:10
  // temp3Token =tempToken.group(3) = AM
  // nameToken/restToken = tempToken.group(4) = Stacy: yeah I am good
  var tempToken;
  tempToken = lineExp.firstMatch(txtLine);
  print("regexParseLine running...");

  // check using RegExp
  if (tempToken != null) {
    print('tempToken is != null');
    print("tempToken.group(0) = ${tempToken.group(0)}");
    print("tempToken.group(1) = ${tempToken.group(1)}");
    print("tempToken.group(2) = ${tempToken.group(2)}");
    print("tempToken.group(3) = ${tempToken.group(3)}");
    print("tempToken.group(4) = ${tempToken.group(4)}");

    // print('-------------------');
    // print(tempToken.group(0));
    // print(txtLine);
    if (tempToken.group(0) == txtLine) {
      // match of whole line
      print('tempToken == txtLine. Return true');
      return true;
    } else {
      print('tempToken is != txtLine. Return false');
      return false;
    }
  } else {
    print("tempToken is null");
    return false;
  }
}

// Function to parse line string from text file
parseLine(String txtLine, int index) {
  RegExp lineExp = RegExp(
      r"([0-9]?[0-9]\/[0-9]?[0-9]\/[0-9]{2,4}),\s([0-9]?[0-9]:[0-9][0-9])\s(AM|PM)?\s?-\s(.*)",
      caseSensitive: false,
      multiLine: false);

  var tempToken;
  var dateToken = "";
  var timeToken = "";
  var nameToken = "";
  var textToken = "";
  var tokenList = [];
  tempToken = lineExp.firstMatch(txtLine);
  // print("regexParseLine running...");
  // print("tempToken.groupCount: ${tempToken.groupCount}");
  // print("tempToken.input: ${tempToken.input}");
  // print("tempToken.pattern: ${tempToken.pattern}");
  // print("tempToken.start: ${tempToken.start}");
  // print("tempToken.end: ${tempToken.end}");
  if (tempToken?.group(1) == null) {
    print("---- tempToken is null ----");
    // Null tempToken is given dummy values
    dateToken = "01/01/1970";
    timeToken = "00:00";
    nameToken = "None";
    textToken = "";
    tokenList = [dateToken, timeToken, nameToken, textToken];
    return tokenList[index];
  } else {
    dateToken = tempToken.group(1);
    timeToken = tempToken.group(2);
    nameToken = tempToken.group(4).split(":")[0];
    textToken = tempToken.group(4).split(":")[1];
    // print(tempToken.group(4).split(":"));
    // print(nameToken);
    // print(textToken);
    tokenList = [dateToken, timeToken, nameToken, textToken];
    // 0 dateToken, 1 timeToken, 2 nameToken, 3 textToken
    return tokenList[index];
  }
}

convertToChatObjects(List chatList) {
  // chatList input List of lines from file
  // convertedList output/returned List of Chat objects
  List<Chat> convertChatList = [];

  chatList.forEach((line) {
    // Build 
    convertChatList.add(Chat(
        date: parseLine(line, 0),
        time: parseLine(line, 1),
        name:parseLine(line, 2).trim(),
        message: parseLine(line, 3),
        fileAttached: "",
      )
    );
    
  });
  return convertChatList;
}
