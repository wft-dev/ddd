import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'confirm_email_controller.g.dart';

@riverpod
class ConfirmEmailController extends _$ConfirmEmailController {
  // State of the confirm email controller.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.signInResultValue(result: null);
  }

  // Confirm update user email with confirmation code.
  Future<void> confirmEmailWithCode(String confirmationCode) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.verifyAttributeUpdate(confirmationCode));
  }
}
