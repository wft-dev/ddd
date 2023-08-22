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
  static const String forgetPassword = 'Forget Password?';
  static const String signUp = 'SignUp';
  static const String forgetYourPassword = 'Forget Your Password?';
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
  static const String createAnAccount = 'Create An Account';
  static const String haveAnAccount = 'I have an already account ';
  static const termAndCondition = 'I agree to all terms and condition';
  static const selectTermAndCondition = 'Please select terms and condition';
  // Login Screen
  static const rememberMeCompleteKey = 'rememberMeComplete';
  static const rememberMe = 'Remember Me';
  static const doNotAccount = 'Don\'t have an account? ';
  static const String code = 'Code';
  static const String save = 'Save';
  static const String send = 'Send';
  static const String submit = 'Submit';
  static const String update = 'Update';
  // Profile Screen
  static const String profile = 'Profile';
  static const String wantToLogout = 'Do you want to logout';
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
  static const String name = 'Name';
  static const String price = 'Price';
  static const String type = 'Type';
  static const String quantity = 'Quantity';
  static const String date = 'Date';
  static const String time = 'Time';
  static const String addMore = 'Add More Additional Items';
  static const String reset = 'Reset';
  static const String remove = 'Remove';
  static const markDefault = 'Do you want to mark this entry as default?';
  static const selectType = 'Select Type';
  static const String report = 'Report';
  static const pleaseSelectType = 'Please select type';
  static const String all = 'All';
  static const String week = 'Week';
  static const String month = 'Month';
  static const String year = 'Year';
  static const String dateRange = 'Date Range';
  static const String searchPlaceHolder =
      'Search by name, type, price, quantity';
  static const String noData = 'No data found';
  static const String noUserSignedIn = 'No user is currently signed in';
  static const String signInAccount = 'Sign in to your account';
  static const String welcome = 'Welcome';
  static const String countyCode = 'IN';
  static const String search = 'Search...';
  static const String productList = 'Product list';
  static const String viewAll = 'View all';
  static const String done = 'Done';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';

  static String confirmationMessage(String? destination, String name) {
    return 'A confirmation code has been sent to $destination. '
        'Please check your $name for the code.';
  }

  static String noSearchResultMessage(String query) {
    return 'There was no match found for "$query". '
        'Please try another search.';
  }
}

// An enum representing the menu type.
enum Options { close, edit, delete }

// An enum representing the filter type.
enum ProductFilterType { all, week, month, year, range }
