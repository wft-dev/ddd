import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  // State of the reset password.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.resetPasswordResultValue(result: null);
  }

  // Send the reset password code to the user's email.
  Future<void> resetUserPassword(String email) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.resetPassword(email));
  }
}
