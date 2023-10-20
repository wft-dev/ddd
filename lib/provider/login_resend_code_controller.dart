import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'login_resend_code_controller.g.dart';

@riverpod
class LoginResendCodeController extends _$LoginResendCodeController {
  // State of the resend code controller for the login.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.resendSignUpCodeResultValue(result: null);
  }

  // Resend the sign up code to the user.
  Future<void> resendSignUpUserCode(String email) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.resendSignUpCode(email));
  }
}
