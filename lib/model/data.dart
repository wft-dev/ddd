// This file is "main.dart"
import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

@freezed
class Data with _$Data {
  const factory Data({
    required String name,
    required Int price,
    required String type,
    required DateTime date,
    required String quantity,
  }) = _Data;
}
