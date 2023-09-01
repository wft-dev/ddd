import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_results.freezed.dart';

@freezed
class AuthResults with _$AuthResults {
  const factory AuthResults.signUpResultValue({required SignUpResult? result}) =
      SignUpResultValue;

  const factory AuthResults.signInResultValue({required SignInResult? result}) =
      SignInResultValue;

  const factory AuthResults.resendSignUpCodeResultValue(
      {required ResendSignUpCodeResult? result}) = ResendSignUpCodeResultValue;

  const factory AuthResults.updatePasswordResultValue(
      {required UpdatePasswordResult? result}) = UpdatePasswordResultValue;

  const factory AuthResults.resetPasswordResultValue(
      {required ResetPasswordResult? result}) = ResetPasswordResultValue;

  const factory AuthResults.updateUserResultValue(
      {required Map<AuthUserAttributeKey, UpdateUserAttributeResult>? result,
      User? user}) = UpdateUserResultValue;
}
