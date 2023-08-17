import 'package:daily_dairy_diary/utils/common_utils.dart';
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
      width: width ?? ResponsiveAppUtil.width * Sizes.p1.sw,
      height: height ?? Sizes.p6.sh,
      child: TextButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: !isIcon
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.p4_5.sw),
                  ),
                )
              : null,
          backgroundColor:
              !isIcon ? MaterialStateProperty.all(AppColors.pinkColor) : null,
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
