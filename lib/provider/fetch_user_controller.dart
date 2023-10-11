import 'dart:async';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_user_controller.g.dart';

@riverpod
class FetchUserController extends _$FetchUserController {
  @override
  FutureOr<User> build() {
    return fetchUser();
  }

  // Fetch user detail.
  Future<User> fetchUser() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final userData = await authRepository.fetchCurrentUserAttributes();
    return userData;
  }
}
