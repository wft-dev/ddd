import 'package:flutter/material.dart';

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
          if (FocusScope.of(context).isFirstFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: child);
  }
}
