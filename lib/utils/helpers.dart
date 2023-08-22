import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/models/Inventory.dart';
import 'package:flutter/material.dart';

// Let's find [Inventory] object for [AppDropDownFiled] value.
Inventory? findInventory(String type) {
  for (var item in inventoryList) {
    if (item.type == type) {
      return item;
    }
  }
  return null;
}

// Hide Keyboard.
void hideKeyboard(BuildContext context) {
  if (FocusScope.of(context).isFirstFocus) {
    FocusScope.of(context).unfocus();
  }
}

// Get [List<String>] from enum.
List<String> enumToStringList<T>(List<T> values) {
  return values.map((value) => value.toString().split('.').last).toList();
}

// Get year from current [DateTime].
final int currentYear = DateTime.now().year;

// Get year from current [DateTime].
final int currentMonth = DateTime.now().month;

// Get [List] of years.
final List<int> years =
    List.generate(currentYear - 1949, (index) => 1950 + index)
        .reversed
        .toList();

// Get [List] of months.
final List<int> months = List.generate(10, (index) => 1 + index);
