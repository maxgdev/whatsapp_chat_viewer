// import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class ChatStyles {
  static const Color whatsAppGreen = Color.fromRGBO(14, 102, 85, 0.8);
  // #0E6655 = Color.fromRGBO(14, 102, 85, 0.8)
  //
  // static const Color antiqueWhite = const Color(0xFFFAEBD7);
  // static const Color aqua = const Color(0xFF00FFFF);
  //
  static final styleSomebody = BubbleStyle(
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

  static final noStyle = BubbleStyle(
    color: Colors.white,
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topCenter,
  );

  static final chatNameStyle =
      TextStyle(fontWeight: FontWeight.w800, color: ChatStyles.whatsAppGreen);

  static final chatInfoStyle = TextStyle(fontSize: 9);

  static final chatInputStyle0 = TextStyle(
    color: Colors.grey[800], fontSize: 18);

  static final chatInputStyle1 = TextStyle(
    color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.bold);

  static final chatInputStyle2 = TextStyle(
    color: Colors.grey[600], fontSize: 14);

  // Background iamge for containers
  static final containerBackgroundImage = BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/images/whatsapp_wallpaper.png"),
        fit: BoxFit.cover),
  );

}

// https://blog.usejournal.com/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
//
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
