import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import '../widgets/loading_indicator.dart';
import 'show_exception_alert_dialog.dart';

// This extension is for [AsyncValue] for checking the states and show the indicator and alert based on the states.
extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    debugPrint('isLoading: $isLoading, hasError: $hasError');
    // isLoading
    //     ? LoadingIndicatorDialog().show(context)
    //     : LoadingIndicatorDialog().dismiss(context);
    if (!isLoading && hasError) {
      final message = error;
      showExceptionAlertDialog(
        context: context,
        title: Strings.error,
        exception: message,
      );
    }
  }
}
