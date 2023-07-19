import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/model/user.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/show_snack_bar.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  /// Get current user.
  Future<bool> getCurrentUser({required bool signedIn}) async {
    final user = await Amplify.Auth.getCurrentUser();
    if (user != null) {
      signedIn = true;
    } else {
      signedIn = false;
    }
    print('$user');
    return signedIn;
  }

  /// Signs a user up with a username, password, and email.
  Future<void> signUpUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String? phoneNumber,
  ) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.name: firstName + lastName,
        AuthUserAttributeKey.email: email,
        if (phoneNumber != null) AuthUserAttributeKey.phoneNumber: phoneNumber,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      print(result);
    } on AuthException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }

  Future<SignInResult> signInUser(String email, String password) async {
    try {
      return await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on Exception {
      rethrow;
    }
  }

  Future<void> signInWithWebUI() async {
    try {
      await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
        options: const SignInWithWebUIOptions(
          pluginOptions: CognitoSignInWithWebUIPluginOptions(
            isPreferPrivateSession: true,
          ),
        ),
      );
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<void> updateUser(
    String firstName,
    String lastName,
    String? phoneNumber,
  ) async {
    try {
      final attributes = [
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.name,
          value: "$firstName $lastName",
        ),
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.phoneNumber,
          value: phoneNumber ?? '',
        ),
      ];
      await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  Future<void> resetPassword(String username) async {
    try {
      await Amplify.Auth.resetPassword(
        username: username,
      );
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  Future<void> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

@Riverpod(keepAlive: true)
Future<void> currentUserRepository(CurrentUserRepositoryRef ref) {
  return ref.watch(authRepositoryProvider).fetchCurrentUserAttributes();
}
