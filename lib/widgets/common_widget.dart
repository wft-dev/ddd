import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

Row loginSignUpButton(BuildContext context, String message, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        message,
        style: CustomTextStyle.textFieldLabelStyle().copyWith(
            fontSize: Sizes.p3_5.sw, fontWeight: Fonts.fontWeightMedium),
      ),
      GestureDetector(
        onTap: () {
          title == Strings.login
              ? const LoginRoute().push(context)
              : const RegisterRoute().push(context);
        },
        child: Text(
          title,
          style: CustomTextStyle.buttonTitleStyle().copyWith(
              color: AppColors.pinkColor,
              fontSize: Sizes.p3_5.sw,
              fontWeight: Fonts.fontWeightMedium),
        ),
      )
    ],
  );
}
