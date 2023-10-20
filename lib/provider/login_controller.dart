import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';
import '../repositories/auth_repository.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  // State of the login controller that will be created when the user is logged in.
  @override
  FutureOr<AuthResults> build() {
    return const AuthResults.signInResultValue(result: null);
  }

  // Log in with the given email and password.
  Future<void> logInUser(String email, String password) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.signInUser(email, password));
  }

  // Log in with Google.
  Future<void> googleLogInUser() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signInWithWebUI());
  }
}
