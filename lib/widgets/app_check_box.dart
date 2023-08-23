import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppCheckbox extends StatefulWidget {
  final bool? listTileCheckBox;
  final bool? isTitle;
  final String errorText;
  final String? title;
  final Function onChange;
  final TextStyle? style;

  const AppCheckbox({
    Key? key,
    required this.listTileCheckBox,
    required this.onChange,
    this.isTitle,
    this.errorText = '',
    this.title,
    this.style,
  }) : super(key: key);

  @override
  State<AppCheckbox> createState() => AppCheckboxState();
}

class AppCheckboxState extends State<AppCheckbox> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.listTileCheckBox ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Sizes.p3.sw),
                child: SizedBox(
                  height: Sizes.p4.sh,
                  width: Sizes.p4.sw,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: AppColors.bgColor, width: Sizes.p2.sw),
                      borderRadius: BorderRadius.circular(
                        Sizes.p1.sw,
                      ), // Border color
                    ),
                    checkColor: AppColors.whiteColor,
                    activeColor: AppColors.darkPurpleColor,
                    value: widget.listTileCheckBox,
                    onChanged: (val) {
                      setState(() {
                        isSelected = val!;
                        widget.onChange(val);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isSelected = !isSelected;
                        widget.onChange(isSelected);
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.left,
                      widget.title ?? '',
                      style: widget.style ??
                          CustomTextStyle.textFieldLabelStyle()
                              .copyWith(fontWeight: Fonts.fontWeightMedium),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (widget.errorText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: Sizes.p5.sw),
              child: Text(
                textAlign: TextAlign.left,
                widget.errorText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CheckboxListTile(
  //     title: Text(widget.title ?? ''),
  //     checkColor: Colors.white,
  //     activeColor: Colors.deepPurple,
  //     value: widget.listTileCheckBox,
  //     controlAffinity: ListTileControlAffinity.leading,
  //     onChanged: (val) {
  //       setState(() {
  //         isSelected = val!;
  //         widget.onChange(val);
  //       });
  //     },
  //   );
  // }
}
