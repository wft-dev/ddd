import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_repository.dart';

part 'update_user_controller.g.dart';

@riverpod
class UpdateUseController extends _$UpdateUseController {
  @override
  FutureOr<void> build() {
    // no state
  }

  Future<void> updateUser(
      String firstName, String lastName, String phoneNumber) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => authRepository.updateUser(firstName, lastName, phoneNumber));
  }
}
