import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/provider/filter_date_controller.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

@riverpod
void productFilterWithDate(
  ProductFilterWithDateRef ref,
) async {
  ref.listen<FilterDate>(filterDateControllerProvider, (_, state) async {
    await ref
        .read(productFilterControllerProvider.notifier)
        .filterProductWithDate(state);
  });
}
