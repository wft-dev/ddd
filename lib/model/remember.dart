// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'remember.freezed.dart';

@freezed
class Remember with _$Remember {
  const factory Remember({
    required String email,
    required String password,
    required bool check,
  }) = _Remember;
}
