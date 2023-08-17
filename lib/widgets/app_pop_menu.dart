import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppPopMenu extends StatefulWidget {
  const AppPopMenu({required this.onSelected, Key? key}) : super(key: key);

  final Function(int, String) onSelected;

  @override
  State<AppPopMenu> createState() => AppPopMenuState();
}

class AppPopMenuState extends State<AppPopMenu> {
  var popupMenuItemIndex = 0;
  Color changeColorAccordingToMenuItem = Colors.red;

  buildPopUpMenu() {
    return PopupMenuButton<int>(
      splashRadius: 0.2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p10.sw)),
      icon: Image.asset(AppImages.dotMoreImage),
      onSelected: (value) {
        onMenuItemSelected(value);
        widget.onSelected(value, Options.values[value].name);
      },
      itemBuilder: (ctx) => [
        buildClosePopupMenuItem(Icons.close, Options.close.index),
        buildPopupMenuItem(
            Options.edit.name.capitalizeFirst(), Options.edit.index),
        buildPopupMenuItem(
            Options.delete.name.capitalizeFirst(), Options.delete.index),
      ],
    );
  }

  // This [PopupMenuItem] is used to show close button.
  PopupMenuItem<int> buildClosePopupMenuItem(IconData iconData, int position) {
    return PopupMenuItem(
      height: Sizes.p2.sh,
      value: position,
      child: IconButton(
        iconSize: Sizes.p4.sw,
        splashRadius: Sizes.p5.sw,
        color: AppColors.darkPurpleColor,
        onPressed: () {
          onMenuItemSelected(position);
        },
        icon: Icon(iconData),
      ),
    );
  }

  // This [PopupMenuItem] is used to show text.
  PopupMenuItem<int> buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      // padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
      height: Sizes.p4.sh,
      value: position,
      textStyle: CustomTextStyle.buttonTitleStyle().copyWith(
        color: AppColors.darkPurpleColor,
        fontSize: Sizes.p3_5.sw,
        fontWeight: Fonts.fontWeightSemiBold,
      ),
      child: Text(textAlign: TextAlign.left, title),
    );
  }

  // Handle
  onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
      // widget.onCanceled?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPopUpMenu();
  }
}
