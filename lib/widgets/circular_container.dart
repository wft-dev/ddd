import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CircularContainer extends StatelessWidget {
  final Widget child;
  final double heightSize;

  const CircularContainer({
    required this.child,
    this.heightSize = Sizes.p07,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        image: const DecorationImage(
          image: AssetImage(AppImages.bgImage),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: Sizes.p5.sh),
      child: SafeArea(
        child: Center(
          child: Container(
              height: ResponsiveAppUtil.height * heightSize,
              // width: ResponsiveAppUtil.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.p12.sw),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.p3.sh, horizontal: Sizes.p10.sw),
              child: child),
        ),
      ),
    );
  }
}
