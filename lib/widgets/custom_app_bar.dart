import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../utils/common_utils.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';

/// [CustomAppBar] is used in the whole app.
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? userName;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool isCenterTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.userName,
    this.actions,
    this.isCenterTitle = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: buildText(),
      actions: actions,
      backgroundColor: AppColors.transparentColor,
      elevation: Sizes.p0,
      iconTheme: IconThemeData(color: AppColors.darkPurpleColor),
      flexibleSpace: ClipPath(
        clipper: CurveClipper(),
        child: SizedBox(
            height: navigationBarHeight.sh + Sizes.p1.sh,
            child: Image.asset(AppImages.appBarImage, fit: BoxFit.fill)),
      ),
    );
  }

  // Title of the [AppBar].
  Widget buildText() {
    return isCenterTitle
        ? Text(
            title,
            style: CustomTextStyle.titleStyle().copyWith(
                fontSize: Sizes.p6.sw, fontWeight: Fonts.fontWeightBold),
          )
        : Row(
            children: [
              Box.gapW5,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.welcome,
                    style: CustomTextStyle.titleStyle().copyWith(
                        fontSize: Sizes.p6.sw,
                        fontWeight: Fonts.fontWeightBold),
                  ),
                  Text(
                    userName ?? '',
                    style: CustomTextStyle.titleStyle().copyWith(
                        fontSize: Sizes.p4.sw,
                        fontWeight: Fonts.fontWeightBold),
                  ),
                ],
              ),
            ],
          );
  }

  // Get navigation bar height.
  @override
  Size get preferredSize => const Size.fromHeight(navigationBarHeight);
}

// CurveClipper for curve bottom of the app bar.
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    final path = Path();
    path.lineTo(Sizes.p0, height - Sizes.p20); // Start from bottom left
    path.quadraticBezierTo(
        width / Sizes.p2, height, width, height - Sizes.p20); // Curve
    path.lineTo(width, Sizes.p0); // Close path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
