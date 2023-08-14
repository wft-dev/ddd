import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/provider/update_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/common_utils.dart';

/// [CustomAppBar] is used in whole the app.
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? userName;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.userName,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        children: [
          Box.gapW5,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.welcome,
                style: CustomTextStyle.titleStyle().copyWith(
                    fontSize: Sizes.p6.sw, fontWeight: Fonts.fontWeightBold),
              ),
              Text(
                userName ?? '',
                style: CustomTextStyle.titleStyle().copyWith(
                    fontSize: Sizes.p4.sw, fontWeight: Fonts.fontWeightMedium),
              ),
            ],
          ),
        ],
      ),
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.transparentColor,
      elevation: 0,
      flexibleSpace: ClipPath(
        clipper: CurveClipper(),
        child: Image.asset(AppImages.appBarImage, fit: BoxFit.fill),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(navigationBarHeight);
}

// CurveClipper for curve bottom of the app bar.
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - Sizes.p20); // Start from bottom left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - Sizes.p20); // Curve
    path.lineTo(size.width, 0); // Close path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
