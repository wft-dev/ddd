import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAlert extends StatelessWidget {
  final String title;
  final String content;

  const AppAlert({
    this.title = '',
    this.content = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () async {
            context.pop(true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            context.pop(false);
          },
          child: const Text('No'),
        )
      ],
    );
  }
}
