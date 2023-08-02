import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'filter_date.freezed.dart';

@freezed
class FilterDate with _$FilterDate {
  const factory FilterDate({
    required DateTime startDate,
    required DateTime endsDate,
    final int? month,
  }) = _FilterDate;
}
