// Validations for the app.
class Validations {
  // Validation for the first name.
  static String? validateFirstName(String value) {
    if (value.isEmpty) return 'First name is required.';
    return validateName(value);
  }

  // Validation for the Last name.
  static String? validateLastName(String value) {
    if (value.isEmpty) return 'Last name is required.';
    return validateName(value);
  }

  // Validation for the string.
  static String? validateString(String value, String textFiled) {
    if (value.isEmpty) return '$textFiled is required.';
    return null;
  }

  // Validation with [RegExp].
  static String? validateName(String value) {
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  // Validation for the email.
  static String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  // Validation for the password.
  static String? validatePassword(String value, String textFiled) {
    if (value.trim().isEmpty) return "Enter $textFiled.";
    if (value.trim().length < 6) {
      return "Password should be greater then 6 character.";
    }
    return null;
  }

  // Validation for the confirm password.
  static String? validateConfirmPassword(String value, String password) {
    if (password != value) return "Confirm password is not matched.";
    if (value.trim().isEmpty) return "Enter confirm password";
    if (value.trim().length < 6) {
      return "Confirm Password should be greater then 6 character.";
    }
    return null;
  }

  // Validation for the OTP.
  static String? validateOTP(String value) {
    if (value.isEmpty) return 'OTP is required.';
    if (value.length != 6) return 'OTP has to be 6 digits.';
    return null;
  }
}
