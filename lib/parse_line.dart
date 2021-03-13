// Function to parse line string fronm text fiile
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
