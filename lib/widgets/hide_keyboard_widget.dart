import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';

// Hide the keyboard when the [GestureDetector] tap is pressed.
class HideKeyboardWidget extends StatelessWidget {
  final Widget child;

  const HideKeyboardWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: child);
  }
}
