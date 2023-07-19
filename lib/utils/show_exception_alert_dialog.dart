import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import '../constant/strings.dart';
import 'show_alert_dialog.dart';

// Show alert for the app.
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: Strings.ok,
    );

// Get message for an exception.
String _message(dynamic exception) {
  if (exception is AuthException) {
    return exception.message;
  }
  return exception.toString();
}
