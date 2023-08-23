import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// This [Row] is used to show login and register screen.
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

// This [Container] is used as rectangular border.
Container buildRoundedContainer({required Widget child}) {
  return Container(
      margin: EdgeInsets.symmetric(
        vertical: Sizes.p1.sh,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.p5.sw,
        vertical: Sizes.p4.sh,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.p8.sw),
        ),
        color: AppColors.alphaPurpleColor,
      ),
      child: child);
}

// [OutlineInputBorder] is used for field borders.
OutlineInputBorder buildBorder(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: Sizes.p03.sw),
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.p5.sw),
    ),
  );
}

// [BoxDecoration] is used for [Container].
BoxDecoration buildBoxDecoration(
    {required Color borderColor, required Color fillColor}) {
  return BoxDecoration(
      border: Border.all(color: borderColor, width: Sizes.p03.sw),
      borderRadius: BorderRadius.all(
        Radius.circular(Sizes.p5.sw),
      ),
      color: fillColor);
}

// [CircularProgressIndicator]
CircularProgressIndicator buildCircularProgressIndicator() {
  return CircularProgressIndicator(color: AppColors.darkPurpleColor);
}
