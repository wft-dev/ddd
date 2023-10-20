import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/provider/filter_date_controller.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:daily_dairy_diary/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

// Listen to the filter date controller provider and the product filter controller provider for update the filter date.
@riverpod
void productFilterWithDate(
    ProductFilterWithDateRef ref, BuildContext context) async {
  ref.watch(productFilterControllerProvider).isLoadingShow(context);
  ref.listen<FilterDate>(filterDateControllerProvider, (_, state) async {
    await ref
        .read(productFilterControllerProvider.notifier)
        .filterProductWithDate(state);
  });
}
