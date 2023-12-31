import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String email,
    required String phoneNumber,
    required String picture,
    required String providerType,
  }) = _User;
}
