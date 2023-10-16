import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../models/auth_results.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  /// Fetch the current auth session.
  Future<bool> isUserSignedIn() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      return result.isSignedIn;
    } on AuthException catch (e) {
      safePrint('Could not retrieve current user: ${e.message}');
      rethrow;
    }
  }

  /// Retrieve the current active user.
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
        AuthUserAttributeKey.name: "$firstName $lastName",
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

  /// Confirm the current sign up for [username] with the [confirmationCode] provided by the user.
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

  /// Sign in for user with [email] and [password].
  Future<AuthResults> signInUser(String email, String password) async {
    try {
      signOut();
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      return AuthResults.signInResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error sign In user: ${e.message}');
      rethrow;
    }
  }

  /// Resend the code that is used to confirm the user's account after sign up.
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

  /// Sign the user out of the current device.
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on Exception {
      rethrow;
    }
  }

  /// Google sigIn and fetch user detail.
  Future<void> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();
      final googleUserDetail = googleSignIn.currentUser;
      String phoneNumber = '';
      if (googleSignInAccount != null) {
        final response = await http.get(
          Uri.parse(''),
          headers: await googleSignInAccount.authHeaders,
        );
        if (response.statusCode != 200) {
          print('People API ${response.statusCode} response: ${response.body}');
        }
        final Map<String, dynamic> data =
            json.decode(response.body) as Map<String, dynamic>;
        print(data);
        final List<dynamic>? phoneNumberList =
            data['phoneNumbers'] as List<dynamic>?;
        final Map<String, dynamic>? phoneNumbers = phoneNumberList?.firstWhere(
          (dynamic contact) => contact['canonicalForm'] != null,
          orElse: () => null,
        ) as Map<String, dynamic>?;
        if (phoneNumbers != null) {
          phoneNumber = phoneNumbers['canonicalForm'];
        }
      }
      if (googleUserDetail != null) {
        await updateUser(googleUserDetail.displayName ?? '', '',
            googleUserDetail.email, phoneNumber, googleUserDetail.photoUrl);
        print(googleUserDetail);
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  /// Use this function to initiate Google sign-in.
  Future<AuthResults> signInWithWebUI() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
        options: const SignInWithWebUIOptions(
          pluginOptions: CognitoSignInWithWebUIPluginOptions(
            isPreferPrivateSession: true,
          ),
        ),
      );
      await signInWithGoogle();
      return AuthResults.signInResultValue(result: result);
    } on AmplifyException catch (e) {
      if (e is UserCancelledException) {
        return const AuthResults.signInResultValue(result: null);
      } else {
        safePrint('Error signing in: ${e.message}');
        rethrow;
      }
    }
  }

  /// Fetch all user attributes of the current user.
  Future<User> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      String name = '';
      String email = '';
      String phoneNumber = '';
      String picture = '';
      String providerType = '';

      for (final element in result) {
        //safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
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
        if (element.userAttributeKey.toString() == 'identities') {
          final List<dynamic> identities = json.decode(element.value);
          if (identities.isNotEmpty) {
            final String provider =
                identities[Sizes.pInt0]['providerName'].toString();
            providerType = provider;
          }
        }
      }

      return User(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          picture: picture,
          providerType: providerType);
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
      rethrow;
    }
  }

  /// Updates multiple user attributes at once.
  Future<AuthResults> updateUser(String firstName, String lastName,
      String email, String? phoneNumber, String? picture) async {
    try {
      final attributes = [
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.name,
          value: "$firstName $lastName",
        ),
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.email,
          value: email,
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
      final result = await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
      return AuthResults.updateUserResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
      rethrow;
    }
  }

  /// Initiates a password reset for the user with the given username.
  Future<AuthResults> resetPassword(String email) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: email,
      );
      return AuthResults.resetPasswordResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      rethrow;
    }
  }

  /// Completes the password reset given a username, new password, and the confirmation code which was sent calling [resetPassword].
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
      return AuthResults.resetPasswordResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      rethrow;
    }
  }

  /// Update the password of the current user.
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

  /// Confirm update user with confirmation code.
  Future<AuthResults> verifyAttributeUpdate(
    String confirmationCode,
  ) async {
    try {
      final result = await Amplify.Auth.confirmUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        confirmationCode: confirmationCode,
      );
      return AuthResults.confirmEmailResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error confirming attribute update: ${e.message}');
      rethrow;
    }
  }

  /// Resend a confirmation code for the given [userAttributeKey].
  Future<AuthResults> resendUserAttributeVerificationCode() async {
    try {
      final result = await Amplify.Auth.resendUserAttributeConfirmationCode(
        userAttributeKey: AuthUserAttributeKey.email,
      );
      return AuthResults.resendUserAttributeCodeResultValue(result: result);
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
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
