// Function to parse line string fronm text fiile
parseLine(String txtLine, int index) {
  var tempToken, dateToken, timeToken, restToken, nameToken, textToken;
  var tokenList;
  tempToken = txtLine.split("-")[0];
  dateToken = tempToken.split(",")[0];
  timeToken = tempToken.split(",")[1];
  restToken = txtLine.split("-")[1];
  nameToken = restToken.split(":")[0];
  textToken = restToken.split(":")[1];
  tokenList = [dateToken, timeToken, nameToken, textToken];
  // 0 dateToken, 1 timeToken, 2 nameToken, 3 textToken
  return tokenList[index];
}

regexParseLine() {
  // RegExp lineExp =  RegExp("([0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s(AM|PM\s-\s([a-zA-Z]*):))", caseSensitive: false, multiLine: false);
  RegExp lineExp = RegExp(
      r"([0-9]*\/([0-9]*\/([0-9]*),\s([0-9]*):[0-9]*)\s(AM|PM\s-\s([a-zA-Z]*):))");

  print("regexParseLine running...");
  // Expectation: true
  if (lineExp.hasMatch('11/17/18, 10:54 PM - John: Hello...')) {
    print('Line 1 is valid');
  }

  // Expectation: true
  if (lineExp.hasMatch(
      '12/3/18, 5:42 PM - Sam: Can you get some tofu chunks at Sainsburys on your way home? Want to put some in the soup and Morrisons didn\'t have any. Thanks.')) {
    print('Line 2 is  is valid');
  }

  // Expectation: false
  if (lineExp.hasMatch(
      '*Spread some laughter, share the cheer.  Let\'s be happy, while we\'re here!*')) {
    print('Line 3 is NOT valid');
  }
}
