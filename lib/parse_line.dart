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

