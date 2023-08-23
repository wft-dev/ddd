import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_date_controller.g.dart';

@riverpod
class FilterDateController extends _$FilterDateController {
  @override
  FilterDate build() {
    return setFilterDate(ProductFilterType.week);
  }

  void updateFilterType(
    ProductFilterType filterType, {
    int? month,
    int? year,
    int? week,
    DateTime? startDateRange,
    DateTime? endDateRange,
  }) {
    state = setFilterDate(filterType,
        month: month,
        year: year,
        week: week,
        startDateRange: startDateRange,
        endDateRange: endDateRange);
  }
}
