import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/repositories/storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_results.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  Future<bool> isUserSignedIn() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      return result.isSignedIn;
    } on AuthException catch (e) {
      safePrint('Could not retrieve current user: ${e.message}');
      rethrow;
    }
  }

  Future<String?> getCurrentUserId() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user.userId;
    } on AuthException catch (e) {
      safePrint('Could not retrieve current user: ${e.message}');
      rethrow;
    }
  }

  /// Signs a user up with a username, password, and email.
  Future<AuthResults> signUpUser(
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
      return AuthResults.signUpResultValue(result: result);
    } on AuthException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<AuthResults> confirmUser(
    String username,
    String confirmationCode,
  ) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      return AuthResults.signUpResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResults> signInUser(String email, String password) async {
    try {
      signOut();
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      return AuthResults.signInResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResults> resendSignUpCode(String email) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(
        username: email,
      );
      return AuthResults.resendSignUpCodeResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
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

  Future<User> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      String name = '';
      String email = '';
      String phoneNumber = '';
      String picture = '';
      for (final element in result) {
        // safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
        if (element.userAttributeKey.toString() == 'name') {
          name = element.value;
        }
        if (element.userAttributeKey.toString() == 'email') {
          email = element.value;
        }
        if (element.userAttributeKey.toString() == 'phone_number') {
          phoneNumber = element.value;
        }
        if (element.userAttributeKey.toString() == 'picture') {
          picture = element.value;
        }
      }
      return User(
          name: name, email: email, phoneNumber: phoneNumber, picture: picture);
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
      rethrow;
    }
  }

  Future<void> updateUser(String firstName, String lastName,
      String? phoneNumber, String? picture) async {
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
        if (picture != null)
          AuthUserAttribute(
            userAttributeKey: AuthUserAttributeKey.picture,
            value: picture,
          ),
      ];
      await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResults> resetPassword(String email) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: email,
      );
      return AuthResults.resetPasswordResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error resetting password111: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResults> confirmResetPassword(
    String email,
    String newPassword,
    String confirmationCode,
  ) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
      return AuthResults.resetPasswordResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResults> updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final result = await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return AuthResults.updatePasswordResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

@riverpod
Future<String?> currentUserRepository(CurrentUserRepositoryRef ref) {
  return ref.watch(authRepositoryProvider).getCurrentUserId();
}

@riverpod
Future<bool> checkUserSignedIn(CheckUserSignedInRef ref) {
  return ref.watch(authRepositoryProvider).isUserSignedIn();
}
