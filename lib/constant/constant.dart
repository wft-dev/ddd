import 'package:daily_dairy_diary/models/Inventory.dart';
import 'package:flutter/material.dart';

class Insets {
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
}

class Fonts {
  static const String mPLUSRoundedBlack = 'MPLUSRounded1c';

  static const fontWeightBlack = FontWeight.w900;
  static const fontWeightExtraBold = FontWeight.w800;
  static const fontWeightBold = FontWeight.w700;
  static const fontWeightSemiBold = FontWeight.w600;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightNormal = FontWeight.w400;
  static const fontWeightLight = FontWeight.w300;
  static const fontWeightExtraLight = FontWeight.w200;
  static const fontWeightThin = FontWeight.w100;
}

final List<Inventory> inventoryDemoList = [
  Inventory(type: 'Milk', price: 20),
  Inventory(type: 'Milk Tonned', price: 30),
  Inventory(type: 'Bread', price: 40),
  Inventory(type: 'Curd', price: 20),
  Inventory(type: 'Sugar', price: 40),
  Inventory(type: 'Rice', price: 70),
];
