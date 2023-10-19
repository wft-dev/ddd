import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/strings.dart';
import '../models/remember.dart';
import '../provider/remember_me_controller.dart';
part 'remember_me_repository.g.dart';

class RememberMeRepository {
  RememberMeRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  // Set the shared preferences for the remember user.
  Future<void> setRememberMeComplete(
      {required bool checkValue,
      required String email,
      required String password}) async {
    await sharedPreferences.setBool(Strings.rememberMeCompleteKey, checkValue);
    await sharedPreferences.setString(Strings.email, email);
    await sharedPreferences.setString(Strings.password, password);
  }

  // Check remember user.
  bool isRememberMeComplete() =>
      sharedPreferences.getBool(Strings.rememberMeCompleteKey) ?? false;

  // Get the shared preferences for the remember user.
  Remember getRememberMe() {
    final isRememberCheck =
        sharedPreferences.getBool(Strings.rememberMeCompleteKey) ?? false;
    final email = sharedPreferences.getString(Strings.email) ?? '';
    final password = sharedPreferences.getString(Strings.password) ?? '';
    return Remember(check: isRememberCheck, email: email, password: password);
  }
}

//[RememberMeRepository] provider.
@Riverpod(keepAlive: true)
RememberMeRepository rememberMeRepository(RememberMeRepositoryRef ref) {
  throw UnimplementedError();
}

// Get remember user information from the provider.
@riverpod
Remember getRemember(GetRememberRef ref) {
  ref.watch(rememberMeControllerProvider);
  return ref.read(rememberMeRepositoryProvider).getRememberMe();
}
