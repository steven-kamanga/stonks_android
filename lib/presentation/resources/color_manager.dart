import 'package:flutter/material.dart';

//Initializes Colors to import in project files
class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color red = HexColor.fromHex("#e61f34");
  static Color greenAccent = HexColor.fromHex("#69F0AE");
  static Color gray = HexColor.fromHex("#2c2c2c");
  static Color lightGray = HexColor.fromHex("#5c5c5c");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color whiteOpacity12 = HexColor.fromHex("#12FFFFFF");
}

//convert the string into colors
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; //8 characters with opacity 100
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
