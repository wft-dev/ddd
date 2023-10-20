import 'dart:collection';

import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/utils/async_value_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event_provider.g.dart';

// Get [LinkedHashMap] of the product list and date for the calendar.
@riverpod
LinkedHashMap<DateTime, List<Product>> getCalendarEvent(
  GetCalendarEventRef ref, {
  BuildContext? context,
  WidgetRef? widgetRef,
}) {
  final productRef = ref.watch(productControllerProvider);
  if (context != null) {
    productRef.isLoadingShow(context);
    productRef.showAlertDialogOnError(context: context, ref: widgetRef);
  }

  final products = productRef.value;
  final events = LinkedHashMap<DateTime, List<Product>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  if (products != null) {
    final List? productItem = products.items;
    if (productItem != null && productItem.isNotEmpty) {
      // print('products $products');
      final Map<DateTime, List<Product>> productMap = {};
      for (var item in productItem) {
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
  }
  return events;
}

// Get [Map] of the product list and product type.
@riverpod
Map<String, List<Product>> getProductByType(GetProductByTypeRef ref) {
  final products = ref.watch(productControllerProvider).value;
  final events = <String, List<Product>>{};
  if (products != null) {
    final List? productItem = products.items;
    if (productItem != null && productItem.isNotEmpty) {
      final Map<String, List<Product>> productMap = {};
      for (var item in productItem) {
        if (item != null) {
          Product productItem = item;
          if (productItem.type != null) {
            String? type = productItem.type;
            if (type != null) {
              if (productMap.isNotEmpty && productMap.containsKey(type)) {
                productMap[type] = [...productMap[type]!, productItem];
              } else {
                Map<String, List<Product>>? productObj = {
                  type: [productItem]
                };
                productMap.addAll(productObj);
              }
            }
          }
        }
      }
      events.addAll(productMap);
      return events;
    }
  }
  return events;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
