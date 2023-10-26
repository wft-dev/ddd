import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/router/router_listenable.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Show alert dialog for the app.
Future<bool?> showAlertDialog(
    {required BuildContext context,
    required String title,
    String? content,
    String? cancelActionText,
    required String defaultActionText,
    WidgetRef? ref}) async {
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
              if (content == Strings.noUserSignedIn ||
                  content == Strings.noUserFound ||
                  content == Strings.noUserExist) {
                context.pop(false);
                if (ref != null) {
                  ref
                      .read(routerListenableProvider.notifier)
                      .userIsLogin(false);
                }
                const LoginRoute().go(context);
              } else {
                context.pop(false);
              }
            }),
      ],
    ),
  );
}

// Show alert dialog with custom action for the app.
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
    barrierDismissible: false,
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

// Show alert dialog with custom action for the app.
Future<bool?> showActionSheetDialog(
    {required BuildContext context,
    required String title,
    String? message,
    List<Widget>? actions}) async {
  final action = CupertinoActionSheet(
    title: Text(
      title,
    ),
    message: message != null ? Text(message) : null,
    actions: actions,
    cancelButton: CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: const Text(Strings.cancel),
      onPressed: () {
        context.pop(false);
      },
    ),
  );

  return showCupertinoModalPopup(
      context: context, builder: (context) => action);
}
