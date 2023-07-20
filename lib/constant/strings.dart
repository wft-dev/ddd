class Strings {
  // Alert strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Error
  static const String error = 'Error';
  static const String success = 'Success';

  // Login Screen
  static const String login = 'Login';
  static const String register = 'Register';
  static const String forgetPassword = 'Forget Password';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Register Screen
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String email = 'Email';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';

  // Login Screen
  static const rememberMeCompleteKey = 'rememberMeComplete';
  static const rememberMe = 'Remember Me';
  static const doNotAccount = 'Don\'t have an account? ';

  static const String code = 'Code';
  static const String save = 'Save';
  static const String send = 'Send';
  static const String submit = 'Submit';

  // Profile Screen
  static const String profile = 'Profile';

  static const String dashboard = 'Dashboard';

  // Change Password Screen
  static const String changePassword = 'Change Password';
  static const String newPassword = 'New Password';
  static const String oldPassword = 'Old Password';
  static const String passwordUpdate = 'Password has been successfully updated';
  static const String resetPasswordSuccess =
      'Password has been successfully reset';
  // Confirm Code Screen
  static const String add = 'Add';
  static const String confirmCode = 'Confirm Code';
  static const String confirmationCode =
      'Add the confirmation code \nreceived on $email';
  static const String resendVerifyCode = 'Resend verification code';
  static const String sendVerificationSuccess =
      'Verification code is send successfully';
  static const String confirm = 'Confirm';
  static const String resend = 'Re Send';
  static const String newPasswordContinue =
      'Enter a new password to continue signing in';

  // Setting Screen
  static const String setting = 'Setting';

  static String confirmationMessage(String? destination, String name) {
    return 'A confirmation code has been sent to $destination. '
        'Please check your $name for the code.';
  }
}
