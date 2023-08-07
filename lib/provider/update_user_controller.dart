import 'dart:async';
import 'dart:io';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/repositories/storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_controller.g.dart';

@riverpod
class UpdateUseController extends _$UpdateUseController {
  @override
  FutureOr<User> build() {
    return fetchUser();
  }

  // Fetch user detail.
  Future<User> fetchUser() async {
    final userData =
        ref.watch(authRepositoryProvider).fetchCurrentUserAttributes();
    return userData;
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
  Future<void> updateUser(String firstName, String lastName, String phoneNumber,
      File? imageFile) async {
    final authRepository = ref.watch(authRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadFile(imageFile);
      }
      await authRepository.updateUser(
          firstName, lastName, phoneNumber, imageUrl);
      return fetchUser();
    });
  }
}
