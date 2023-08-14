import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppCheckbox extends StatefulWidget {
  final bool? listTileCheckBox;
  final bool? isTitle;
  final String? title;
  final Function onChange;

  const AppCheckbox({
    Key? key,
    required this.listTileCheckBox,
    required this.onChange,
    this.isTitle,
    this.title,
  }) : super(key: key);

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.listTileCheckBox ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.bgColor, width: Sizes.p2.sw),
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
        TextButton(
          onPressed: () {
            setState(() {
              isSelected = !isSelected;
              widget.onChange(isSelected);
            });
          },
          child: Text(
            widget.title ?? '',
            style: CustomTextStyle.textFieldLabelStyle()
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
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
