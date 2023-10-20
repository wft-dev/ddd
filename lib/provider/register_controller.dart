import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  // State of the register controller.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.signInResultValue(result: null);
  }

  // Register user.
  Future<void> registerUser(String firstName, String lastName, String email,
      String password, String phoneNumber) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signUpUser(
        firstName, lastName, email, password, phoneNumber));
  }
}
