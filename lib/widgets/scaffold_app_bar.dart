import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScaffoldAppBar extends StatelessWidget {
  final Widget child;
  final String? barTitle;
  final List<Widget>? barActions;
  const ScaffoldAppBar({
    required this.child,
    this.barTitle,
    this.barActions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWidget(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          backgroundColor: AppColors.whiteColor,
          title: barTitle ?? '',
          actions: barActions,
        ),
        body: Container(
          height: ResponsiveAppUtil.height,
          color: AppColors.alphaPurpleColor,
          child: Container(
            height: ResponsiveAppUtil.height * Sizes.p01.sh,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(Sizes.p12.sw),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
            child: SafeArea(child: child),
          ),
        ),
      ),
    );
  }
}
