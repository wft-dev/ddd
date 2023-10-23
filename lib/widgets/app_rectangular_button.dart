import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// This [AppRectangularButton] is used to display a rectangular button.
class AppRectangularButton extends StatefulWidget {
  final int index;
  final int activeIndex;
  final String? text;
  final String? value;

  final Function(int) onPress;
  final double? width;
  final double? height;
  const AppRectangularButton({
    Key? key,
    this.text,
    this.value,
    required this.index,
    required this.activeIndex,
    required this.onPress,
    this.width,
    this.height,
  }) : super(key: key);
  @override
  State<AppRectangularButton> createState() => AppRectangularButtonState();
}

class AppRectangularButtonState extends State<AppRectangularButton> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? heightValue = widget.height ?? Sizes.p3.sh;
    bool isIndexSelected = widget.index == widget.activeIndex ? true : false;
    return SizedBox(
      // width: width ?? ResponsiveAppUtil.width * Sizes.p1.sw,
      height: heightValue,
      child: TextButton(
        onPressed: () => widget.onPress(widget.index),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
                vertical: Sizes.p01.sh, horizontal: Sizes.p3.sw),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(heightValue),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            isIndexSelected
                ? AppColors.darkPurpleColor
                : AppColors.alphaPurpleColor,
          ),
        ),
        child: Row(
          children: [
            Text(
              widget.text ?? '',
              style: CustomTextStyle.buttonTitleStyle().copyWith(
                  color: isIndexSelected
                      ? AppColors.whiteColor
                      : AppColors.thinPurpleColor,
                  fontSize: Sizes.p3_5.sw,
                  fontWeight: isIndexSelected
                      ? Fonts.fontWeightBlack
                      : Fonts.fontWeightBold),
            ),
            Container(
              margin: EdgeInsets.only(left: Sizes.p1.sw),
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.p01.sh, horizontal: Sizes.p1_5.sw),
              decoration: BoxDecoration(
                color: isIndexSelected
                    ? AppColors.whiteColor
                    : AppColors.alphaPurpleColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Sizes.p2.sw),
              ),
              child: Text(
                widget.value ?? '',
                style: CustomTextStyle.buttonTitleStyle().copyWith(
                  color: isIndexSelected
                      ? AppColors.darkPurpleColor
                      : AppColors.thinPurpleColor,
                  fontSize: Sizes.p2_5.sw,
                  fontWeight: Fonts.fontWeightBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
