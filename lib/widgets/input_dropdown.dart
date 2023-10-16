import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:daily_dairy_diary/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key? key,
    this.labelText,
    required this.valueText,
    required this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String? labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback? onPressed;
  // TextEditingController textController = TextEditingController(text: "");

  // @override
  // Widget build(BuildContext context) {
  //   textController.text = valueText;
  //   return InkWell(
  //     onTap: onPressed,
  //     child: AppTextFormField(
  //       suffix: Icon(
  //         color: AppColors.thinPurpleColor,
  //         size: Sizes.p5.sw,
  //         Icons.visibility_off_outlined,
  //       ),
  //       onTap: onPressed,
  //       // onChanged: (value) {
  //       //   print('object');
  //       // },
  //       readOnly: true,
  //       controller: textController,
  //       label: labelText ?? '',
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.p1.sh),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p3.sw),
                child: Text(
                  labelText ?? '',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.textFieldLabelStyle(),
                ),
              ),
              Box.gapH1,
              Container(
                padding: EdgeInsets.only(
                    top: Sizes.p1.sh,
                    bottom: Sizes.p1.sh,
                    left: Sizes.p4.sw,
                    right: Sizes.p3.sw),
                decoration: buildBoxDecoration(
                    borderColor: AppColors.lightPurpleColor,
                    fillColor: AppColors.whiteColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Text(valueText, style: valueStyle),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: Sizes.p6.sw, color: AppColors.thinPurpleColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
