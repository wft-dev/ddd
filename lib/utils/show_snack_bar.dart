import 'package:flutter/material.dart';

class ShowSnackBar {
  // Show the snack bar for message.
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
