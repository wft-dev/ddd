import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';

class AppPopMenu extends StatefulWidget {
  const AppPopMenu({required this.onSelected, Key? key}) : super(key: key);

  final Function(int, String) onSelected;

  @override
  State<AppPopMenu> createState() => AppPopMenuState();
}

class AppPopMenuState extends State<AppPopMenu> {
  var popupMenuItemIndex = 0;
  Color changeColorAccordingToMenuItem = Colors.red;

  // This is used to display [PopupMenuButton].
  PopupMenuButton buildPopUpMenu() {
    return PopupMenuButton<int>(
      tooltip: '',
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p7.sw)),
      icon: Image.asset(AppImages.dotMoreImage),
      onSelected: (value) {
        onMenuItemSelected(value);
        widget.onSelected(value, Options.values[value].name);
      },
      itemBuilder: (ctx) => [
        buildPopupMenuSpace(),
        buildClosePopupMenuItem(Icons.close, Options.close.index, ctx),
        buildPopupMenuItem(
            Options.edit.name.capitalizeFirst(), Options.edit.index),
        buildPopupMenuItem(
            Options.delete.name.capitalizeFirst(), Options.delete.index),
        buildPopupMenuSpace(),
      ],
    );
  }

  // This [PopupMenuItem] is used to show close button.
  PopupMenuItem<int> buildClosePopupMenuItem(
      IconData iconData, int position, BuildContext context) {
    return PopupMenuItem(
      height: Sizes.p3.sh,
      value: position,
      onTap: () {
        Navigator.of(context).maybePop();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(
          iconData,
          size: Sizes.p2_5.sh,
        ),
      ),
    );
  }

  // This [PopupMenuItem] is used to show text.
  PopupMenuItem<int> buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      height: Sizes.p4.sh,
      value: position,
      textStyle: CustomTextStyle.buttonTitleStyle().copyWith(
        color: AppColors.darkPurpleColor,
        fontSize: Sizes.p3_5.sw,
        fontWeight: Fonts.fontWeightSemiBold,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Sizes.p3.sw),
        child: Text(
          textAlign: TextAlign.left,
          title,
        ),
      ),
    );
  }

  // This [PopupMenuItem] is used to top and bottom space.
  PopupMenuItem<int> buildPopupMenuSpace() {
    return PopupMenuItem(
      enabled: false,
      height: Sizes.p1.sh,
      value: Sizes.pIntN1,
      child: Container(),
    );
  }

  // Set menu item index on menu item selected.
  onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPopUpMenu();
  }
}
