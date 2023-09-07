import 'package:daily_dairy_diary/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import 'show_exception_alert_dialog.dart';

typedef VoidAsyncValue = AsyncValue<void>;

// This extension is for [AsyncValue] for checking the states and show the indicator and alert based on the states.
extension AsyncValueUI on AsyncValue {
  bool get isLoading => this is AsyncLoading<void>;

  void isLoadingShow(BuildContext context) {
    debugPrint('isLoadingShow: $isLoading,');
    Future.delayed(Duration.zero, () {
      isLoading
          ? LoadingOverlay.of(context)?.show()
          : LoadingOverlay.of(context)?.hide();
    });
  }

  void showAlertDialogOnError({required BuildContext context, WidgetRef? ref}) {
    debugPrint(
        'isLoading: $isLoading, hasError: $hasError, hasValue: $hasValue');
    if (!isLoading && hasError) {
      final message = error;
      showExceptionAlertDialog(
        context: context,
        title: Strings.error,
        exception: message,
        ref: ref,
      );
    }
  }
}
