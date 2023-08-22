import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppSegmentButton extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const AppSegmentButton({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        labels.length,
        (index) => Expanded(
          child: Container(
            margin: EdgeInsets.only(
                right: index == (labels.length - Sizes.p1)
                    ? Sizes.p0
                    : Sizes.p02.sw),
            child: TextButton(
              style: ButtonStyle(
                // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                //   EdgeInsets.symmetric(
                //       vertical: Sizes.p01.sh, horizontal: Sizes.p3.sw),
                // ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: index == Sizes.p0
                        ? BorderRadius.only(
                            topLeft: Radius.circular(Sizes.p4.sw),
                            bottomLeft: Radius.circular(Sizes.p4.sw))
                        : index == (labels.length - Sizes.p1)
                            ? BorderRadius.only(
                                topRight: Radius.circular(Sizes.p4.sw),
                                bottomRight: Radius.circular(Sizes.p4.sw))
                            : BorderRadius.circular(Sizes.p0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  index == selectedIndex
                      ? AppColors.alphaPurpleColor
                      : AppColors.whiteColor,
                ),
              ),
              onPressed: () => onIndexChanged(index),
              child: Text(
                labels[index].capitalizeFirst(),
                style: CustomTextStyle.buttonTitleStyle().copyWith(
                    color: index == selectedIndex
                        ? AppColors.darkPurpleColor
                        : AppColors.darkPurpleColor,
                    fontSize: Sizes.p3_5.sw,
                    fontWeight: index == selectedIndex
                        ? Fonts.fontWeightSemiBold
                        : Fonts.fontWeightBold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
