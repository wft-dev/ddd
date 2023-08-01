import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPress;
  final bool isIcon;
  final double? width;
  final double? height;
  final Widget? icon;
  const AppButton({
    Key? key,
    this.text,
    required this.onPress,
    this.width,
    this.height,
    this.isIcon = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150.sw,
      height: height ?? 6.sh,
      child: TextButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: !isIcon
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0.sw),
                  ),
                )
              : null,
          backgroundColor:
              !isIcon ? MaterialStateProperty.all(Colors.black) : null,
        ),
        child: isIcon
            ? Container(child: icon)
            : Text(
                text ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
