import 'dart:convert';
void regexDemo() {
    //------------------------allMatches Example---------------------------------
    print('Example 1');

    //We want to extract ages from the following string:
    String str1 = 'Sara is 26 years old. Maria is 18 while Masood is 8.';

    //Declaring a RegExp object with a pattern that matches sequences of digits
    RegExp reg1 = new RegExp(r'(\d+)');

    //Iterating over the matches returned from allMatches
    Iterable allMatches = reg1.allMatches(str1);
    var matchCount = 0;
    allMatches.forEach((match) {
        matchCount += 1;
        print('Match $matchCount: ' + str1.substring(match.start, match.end));
    });

    //------------------------firstMatch Example---------------------------------
    print('\nExample 2');

    //We want to find the first sequence of word characters in the following string:
    //Note: A word character is any single letter, number or underscore
    String str2 = '#%^!_as22 d3*fg%';

    //Declaring a RegExp object with a pattern that matches sequences of word 
    //characters
    RegExp reg2 = new RegExp(r'(\w+)');

    //Using the firstMatch function to display the first match found
    Match firstMatch = reg2.firstMatch(str2);
    print('First match: ${str2.substring(firstMatch.start, firstMatch.end)}');

    //--------------------------hasMatch Example---------------------------------
    print('\nExample 3');

    //We want to check whether a following strings have white space or not
    String str3 = 'Achoo!';
    String str4 = 'Bless you.';
    
    //Declaring a RegExp object with a pattern that matches whitespaces
    RegExp reg3 = new RegExp(r'(\s)');

    //Using the hasMatch method to check strings for whitespaces
    print('The string "' + str3 +'" contains whitespaces: ${reg3.hasMatch(str3)}');
    print('The string "' + str4 +'" contains whitespaces: ${reg3.hasMatch(str4)}');

    //--------------------------stringMatch Example-------------------------------
    print('\nExample 4');

    //We want to print the first non-digit sequence in the following strings;
    String str5 = '121413dog299toy01food';
    String str6 = '00Tom1231frog';

    //Declaring a RegExp object with a pattern that matches sequence of non-digit 
    //characters
    RegExp reg4 = new RegExp(r'(\D+)');

    //Using the stringMatch method to find the first non-digit match:
    String str5Match = reg4.stringMatch(str5);
    String str6Match = reg4.stringMatch(str6);
    print('First match for "' + str5 + '": $str5Match');
    print('First match for "' + str6 + '": $str6Match');

    //--------------------------matchAsPrefix Example-----------------------------
    print('\nExample 5');

    //We want to check if the following strings start with the word "Hello" or not:
    String str7 = 'Greetings, fellow human!';
    String str8 = 'Hello! How are you today?';

    //Declaring a RegExp object with a pattern that matches the word "Hello"
    RegExp reg5 = new RegExp(r'Hello');

    //Using the matchAsPrefix method to match "Hello" to the start of the strings
    Match str7Match = reg5.matchAsPrefix(str7);
    Match str8Match = reg5.matchAsPrefix(str8);
    print('"' + str7 + '" starts with hello: ${str7Match != null}');
    print('"' + str8 + '" starts with hello: ${str8Match != null}');
}