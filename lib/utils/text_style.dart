import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Custom text styles use for the app.
class CustomTextStyle {
  static TextStyle titleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(36, isWidth),
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle loginTitleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(36, isWidth),
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle loginTitleSecondaryStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(33, isWidth),
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle registerButtonStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(4, isWidth),
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
  }

  static double checkSize(double fontSize, bool isWidth) {
    return isWidth ? fontSize.sw : fontSize.sh;
  }
}
