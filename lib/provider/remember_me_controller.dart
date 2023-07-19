import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/remember_me_repository.dart';

part 'remember_me_controller.g.dart';

@riverpod
class RememberMeController extends _$RememberMeController {
  @override
  FutureOr<void> build() {
    // no state
  }

  Future<void> completeRememberMe(
      {required bool checkValue,
      required String email,
      required String password}) async {
    final rememberMeRepository = ref.watch(rememberMeRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        rememberMeRepository.setRememberMeComplete(
            checkValue: checkValue, password: password, email: email));
  }
}
