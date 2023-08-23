import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Custom text styles use for the app.
class CustomTextStyle {
  static TextStyle titleHeaderStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p8, isWidth),
      color: AppColors.darkPurpleColor,
      fontWeight: Fonts.fontWeightBold,
    );
  }

  static TextStyle textFieldLabelStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p3_3, isWidth),
      color: AppColors.darkPurpleColor,
      fontWeight: Fonts.fontWeightBold,
    );
  }

  static TextStyle textFieldTitleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4_3, isWidth),
      color: AppColors.darkPurpleColor,
      fontWeight: Fonts.fontWeightMedium,
    );
  }

  static TextStyle buttonTitleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4_5, isWidth),
      color: AppColors.whiteColor,
      fontWeight: Fonts.fontWeightMedium,
    );
  }

  static TextStyle titleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4_5, isWidth),
      color: AppColors.darkPurpleColor,
      fontWeight: Fonts.fontWeightMedium,
    );
  }

  static TextStyle calendarTitleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4, isWidth),
      color: AppColors.darkPurpleColor,
      fontWeight: Fonts.fontWeightMedium,
    );
  }

  static TextStyle loginTitleStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4_5, isWidth),
      color: Colors.black,
      fontWeight: Fonts.fontWeightMedium,
    );
  }

  static TextStyle loginTitleSecondaryStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(Sizes.p4_5, isWidth),
      color: Colors.white,
      fontWeight: Fonts.fontWeightNormal,
    );
  }

  static TextStyle registerButtonStyle({bool isWidth = true}) {
    return TextStyle(
      fontSize: checkSize(4, isWidth),
      color: Colors.black,
      fontWeight: Fonts.fontWeightNormal,
    );
  }

  static double checkSize(double fontSize, bool isWidth) {
    return isWidth ? fontSize.sw : fontSize.sh;
  }
}
