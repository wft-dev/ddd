import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// [AppButton] is used to show the [TextButton].
class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPress;
  final bool isIcon;
  final bool isEnabled;
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
    this.isEnabled = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? ResponsiveAppUtil.width * Sizes.p1.sw,
      height: height ?? Sizes.p7.sh,
      child: TextButton(
        onPressed: isEnabled ? onPress : null,
        style: ButtonStyle(
          shape: !isIcon
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.p4_5.sw),
                  ),
                )
              : null,
          foregroundColor: isEnabled
              ? MaterialStateProperty.all(AppColors.pinkColor)
              : MaterialStateProperty.all(AppColors.dimPurpleColor),
          backgroundColor: isEnabled
              ? MaterialStateProperty.all(AppColors.pinkColor)
              : MaterialStateProperty.all(AppColors.dimPurpleColor),
        ),
        child: isIcon
            ? Container(child: icon)
            : Text(
                text ?? '',
                style: CustomTextStyle.buttonTitleStyle(),
              ),
      ),
    );
  }
}
