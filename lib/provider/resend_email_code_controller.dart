import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'resend_email_code_controller.g.dart';

@riverpod
class ResendEmailCodeController extends _$ResendEmailCodeController {
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.resendUserAttributeCodeResultValue(result: null);
  }

  Future<void> resendSignUpUserCode() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.resendUserAttributeVerificationCode());
  }
}
