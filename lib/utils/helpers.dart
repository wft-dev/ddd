import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:daily_dairy_diary/models/Inventory.dart';

// Let's find [Inventory] object for [AppDropDownFiled] value.
Inventory? findInventory(String type, List<Inventory> inventoryList) {
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
final int currentMonth = DateTime.now().month - 1;

// Get [List] of years.
final List<int> years =
    List.generate(currentYear - 1949, (index) => 1950 + index)
        .reversed
        .toList();

// Get [List] of months.
final List<String> months = DateFormat.MMMM().dateSymbols.MONTHS;

List<String> sortedMonths() {
  List<String> sorted = [];
  sorted.addAll(months.sublist(currentMonth));
  sorted.addAll(months.sublist(0, currentMonth));
  return sorted;
}

// Get [List] of Weeks.
List<String> weeks = ['Week One', 'Week Two', 'Week Three', 'Week Four'];

// Get phone number with country detail.
Future<PhoneNumber> getPhoneNumber(String phoneNumber) async {
  PhoneNumber number =
      await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
  return number;
}
