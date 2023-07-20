import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'confirm_user_controller.g.dart';

@riverpod
class ConfirmUserController extends _$ConfirmUserController {
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.signInResultValue(result: null);
  }

  Future<void> confirmUserWithCode(
      String username, String confirmationCode) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.confirmUser(username, confirmationCode));
  }
}
