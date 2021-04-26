// import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class ChatColors {
  static const Color whatsAppGreen = Color.fromRGBO(14, 102, 85, 0.8);
  // #0E6655 = Color.fromRGBO(14, 102, 85, 0.8)
  // 
  // static const Color antiqueWhite = const Color(0xFFFAEBD7);
  // static const Color aqua = const Color(0xFF00FFFF);

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