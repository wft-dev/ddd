import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showError(BuildContext? context, String message) {
    ScaffoldMessenger.of(context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
