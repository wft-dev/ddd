import 'dart:async';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:daily_dairy_diary/models/auth_results.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/repositories/storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_controller.g.dart';

@riverpod
class UpdateUserController extends _$UpdateUserController {
  @override
  FutureOr<AuthResults> build() {
    return fetchUser();
  }

  // Fetch user detail.
  Future<AuthResults> fetchUser(
      {Map<AuthUserAttributeKey, UpdateUserAttributeResult>? result}) async {
    final authRepository = ref.watch(authRepositoryProvider);
    final userData = await authRepository.fetchCurrentUserAttributes();
    return AuthResults.updateUserResultValue(result: result, user: userData);
  }

  // Upload user image into amplify storage and get image url.
  Future<String?> uploadFile(File file) async {
    final fileKey = await ref.read(storageRepositoryProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageRepositoryProvider).getImageUrl(fileKey);
      return imageUrl;
    }
    return null;
  }

  // Update user profile.
  Future<void> updateUser(String firstName, String lastName, String email,
      String phoneNumber, File? imageFile) async {
    final authRepository = ref.watch(authRepositoryProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadFile(imageFile);
      }
      AuthResults data = await authRepository.updateUser(
          firstName, lastName, email, phoneNumber, imageUrl);
      if (data is UpdateUserResultValue) {
        return fetchUser(result: data.result);
      }
      return fetchUser();
    });
  }
}
