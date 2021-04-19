import '../model/chat_model.dart';

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
  //
  // Match line with dd/mm/yy, hh:mm - <name>:
  // DATE, TIME - NAME : TEXT
  var tempToken;
  tempToken = lineExp.firstMatch(txtLine);

  // check using RegExp
  if (tempToken != null) {
    // print('-------------------');
    // print(tempToken.group(0));
    // print(txtLine);
    if (tempToken.group(0) == txtLine) {
      // match of whole line
      // print('tempToken == txtLine. Return true');
      return true;
    } else {
      // print('tempToken is != txtLine. Return false');
      return false;
    }
  } else {
    // print("tempToken is null");
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

  if (tempToken?.group(0) == null) {
    print("---- tempToken is null ----");
    print("tempToken.group(0): ${tempToken.group(0)}");
    print("tempToken.group(0): ${tempToken.group(1)}");
    // Null tempToken is given dummy values
    dateToken = "01/01/1970";
    timeToken = "00:00";
    nameToken = "None";
    textToken = "";
    // tokenList = [dateToken, timeToken, nameToken, textToken];
    // return tokenList[index];
  } else {
    dateToken = tempToken.group(1);
    timeToken = tempToken.group(2);

    if (tempToken.group(4).split(":").length < 2) {
      // if no name them just return text
      nameToken = ""; // no name
      textToken = tempToken.group(4);
    } else {
      nameToken = tempToken.group(4).split(":")[0];
      textToken = tempToken.group(4).split(":")[1];
    }
    // tokenList = [dateToken, timeToken, nameToken, textToken];
    // // 0 dateToken, 1 timeToken, 2 nameToken, 3 textToken
    // return tokenList[index];
  }
    tokenList = [dateToken, timeToken, nameToken, textToken];
    // 0 dateToken, 1 timeToken, 2 nameToken, 3 textToken
    return tokenList[index];
}

convertToChatObjects(List chatList) {
  // chatList input List of lines from file
  // convertedList output/returned List of Chat objects
  List<Chat> convertedChatList = [];

  chatList.forEach((line) {
    // Build Chat and add to List
    convertedChatList.add(Chat(
      date: parseLine(line, 0),
      time: parseLine(line, 1),
      name: parseLine(line, 2).trim(),
      message: parseLine(line, 3),
      fileAttached: "",
    ));
  });
  return convertedChatList;
}

formatFilename(String text) {
  // remove all '/' characters
  var allBackSlash = text.replaceAll('/', '');
  // remove all '&' characters
  var allAmpersand = allBackSlash.replaceAll('&', '');
  // remove all spaces
  var allSpaces = allAmpersand.replaceAll(' ', '_');
  // remove .txt & make all lowercase
  var result = allSpaces.split('.txt')[0].toLowerCase();
  // print(result);
  // convert function to use to regex...
  return result;
}
