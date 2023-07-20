import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'update_password_controller.g.dart';

@riverpod
class UpdatePasswordController extends _$UpdatePasswordController {
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.updatePasswordResultValue(result: null);
  }

  Future<void> updateUserPassword(
    String oldPassword,
    String newPassword,
  ) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.updatePassword(oldPassword, newPassword));
  }
}
