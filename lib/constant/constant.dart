import 'package:daily_dairy_diary/models/Inventory.dart';

class Insets {
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
}

class Fonts {
  static const String fontName = '';
}

final List<Inventory> inventoryList = [
  Inventory(type: 'Milk', price: 20),
  Inventory(type: 'Milk Tonned', price: 30),
  Inventory(type: 'Bread', price: 20),
  Inventory(type: 'Curd', price: 20),
  Inventory(type: 'Sugar', price: 60),
  Inventory(type: 'Rice', price: 160),
];
