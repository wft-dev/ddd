import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'confirm_reset_password_controller.g.dart';

@riverpod
class ConfirmResetPasswordController extends _$ConfirmResetPasswordController {
  // State of the reset password controller.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.resetPasswordResultValue(result: null);
  }

  // Function to confirm the user's reset password.
  Future<void> confirmUserResetPassword(
    String email,
    String newPassword,
    String confirmationCode,
  ) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.confirmResetPassword(
        email, newPassword, confirmationCode));
  }
}
