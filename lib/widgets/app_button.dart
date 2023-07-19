import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const AppButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.sw,
      height: 6.sh,
      child: TextButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0.sw),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
