import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'resend_code_controller.g.dart';

@riverpod
class ResendCodeController extends _$ResendCodeController {
  // State of the resend code.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.resendSignUpCodeResultValue(result: null);
  }

  // Resend the code that is used to confirm the user's account after sign up.
  Future<void> resendSignUpUserCode(String email) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.resendSignUpCode(email));
  }
}
