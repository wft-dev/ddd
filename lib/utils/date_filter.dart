import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/screens/report.dart';

FilterDate setFilterDate(
  ProductFilterType filterType, {
  int? month,
  int? year,
  DateTime? startDateRange,
  DateTime? endDateRange,
}) {
  final now = DateTime.now();
  FilterDate date;
  switch (filterType) {
    case ProductFilterType.week:
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      date = FilterDate(startDate: startOfWeek, endsDate: endOfWeek);
      break;
    case ProductFilterType.month:
      final startOfMonth = DateTime(now.year, month ?? now.month, 1);
      final endOfMonth = DateTime(now.year, ((month ?? now.month) + 1), 0);
      date = FilterDate(startDate: startOfMonth, endsDate: endOfMonth);
      break;
    case ProductFilterType.year:
      final startOfYear = DateTime(year ?? now.year, 1, 1);
      final endOfYear = DateTime(year ?? now.year, 12, 31);
      date = FilterDate(startDate: startOfYear, endsDate: endOfYear);
      break;
    case ProductFilterType.dateRange:
      final startOfYear = startDateRange;
      final endOfYear = endDateRange;
      date = FilterDate(startDate: startOfYear!, endsDate: endOfYear!);
      break;
  }
  return date;
}
