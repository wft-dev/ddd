import 'dart:collection';

import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event_provider.g.dart';

@riverpod
LinkedHashMap<DateTime, List<Product>> getCalendarEvent(
    GetCalendarEventRef ref) {
  final products = ref.watch(productControllerProvider).value;
  final events = LinkedHashMap<DateTime, List<Product>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  if (products != null && products.isNotEmpty) {
    // print('products $products');
    final Map<DateTime, List<Product>> productMap = {};
    for (var item in products) {
      if (item != null) {
        Product productItem = item;
        if (productItem.date != null) {
          DateTime productUtcDate = productItem.date!.getDateTimeInUtc();
          DateTime? utcToLocalDate = productUtcDate.toLocal();
          DateTime? date = DateTime(
              utcToLocalDate.year, utcToLocalDate.month, utcToLocalDate.day);
          if (productMap.isNotEmpty && productMap.containsKey(date)) {
            productMap[date] = [...productMap[date]!, productItem];
          } else {
            Map<DateTime, List<Product>>? productObj = {
              date: [productItem]
            };
            productMap.addAll(productObj);
          }
        }
      }
    }
    events.addAll(productMap);
    return events;
  }
  return events;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
