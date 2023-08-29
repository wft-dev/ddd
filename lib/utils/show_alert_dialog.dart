import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Show alert dialog for the app.
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => context.pop(false),
          ),
        TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              if (content == Strings.noUserSignedIn) {
                context.pop(false);
                const LoginRoute().go(context);
              } else {
                context.pop(false);
              }
            }),
      ],
    ),
  );
}

Future<bool?> showAlertActionDialog({
  required BuildContext context,
  required String title,
  String? content,
  String cancelActionText = Strings.cancel,
  required VoidCallback onYesPress,
  bool isShowCancel = false,
  String defaultActionText = Strings.ok,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              context.pop(false);
              onYesPress();
            }),
        if (isShowCancel)
          TextButton(
              child: Text(cancelActionText),
              onPressed: () {
                context.pop(false);
              }),
      ],
    ),
  );
}
