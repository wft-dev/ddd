import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/models/Inventory.dart';

// Let's find [Inventory] object for [AppDropDownFiled] value.
Inventory? findInventory(String type) {
  for (var item in inventoryList) {
    if (item.type == type) {
      return item;
    }
  }
  return null;
}
