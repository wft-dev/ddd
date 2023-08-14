import 'package:flutter/material.dart';

class HexColors {
  static Color fromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexCode.length == 6) {
      hexColor = 'FF$hexCode';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
// header B6A2FF, Text 382D60,  calender bg EDE9FB, 500ml text color AFA8C8,EDE9FB

class AppColors {
  static Color primary = HexColors.fromHex('#399df8');
  static Color bgColor = HexColors.fromHex('#E5EBF9');
  static Color grayColor = HexColors.fromHex('#8E8E90');
  static Color blackColor = HexColors.fromHex('#000000');
  static Color whiteColor = HexColors.fromHex('#FFFFFF');
  static Color darkPurpleColor = HexColors.fromHex('#382D60');
  static Color lightPurpleColor = HexColors.fromHex('#B6A2FF');
  static Color dimPurpleColor = HexColors.fromHex('#AFA8C8');
  static Color alphaPurpleColor = HexColors.fromHex('#EDE9FB');
  static Color thinPurpleColor = HexColors.fromHex('#AFA8C8');
  static Color pinkColor = HexColors.fromHex('#FFA2BF');
  static Color transparentColor = Colors.transparent;
}

class ThemeColor {
  static Color primary = HexColors.fromHex('#399df8');
  static Color bgColor = HexColors.fromHex('#010101');
}
