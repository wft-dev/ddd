import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomDropdownButton2 extends StatelessWidget {
  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.p1_5.sh),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          //To avoid long text overflowing.
          isExpanded: true,
          decoration: InputDecoration(
            // errorText: errorText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: Sizes.p05.sw),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.p2.sw),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: Sizes.p05.sw),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.p2.sw),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ThemeColor.primary, width: Sizes.p05.sw),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.p2.sw),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: Sizes.p05.sw),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.p2.sw),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes.p1.sw,
              vertical: Sizes.p2.sh,
            ),
          ),
          hint: Container(
            alignment: hintAlignment,
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: Sizes.p4_5.sw,
              ),
            ),
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.p4_5.sw,
            fontWeight: FontWeight.w500,
          ),
          value: value,
          items: dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) =>
              Validations.validateString(value ?? '', Strings.type),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          buttonStyleData: ButtonStyleData(
            // height: buttonHeight ?? 40,
            // width: buttonWidth ?? 140,
            padding: buttonPadding ?? EdgeInsets.only(right: Sizes.p4.sw),
            // decoration: buttonDecoration ??
            //     BoxDecoration(
            //       borderRadius: BorderRadius.circular(Sizes.p2.sw),
            //       border: Border.all(
            //         color: Colors.grey,
            //         width: Sizes.p05.sw,
            //       ),
            //     ),
            // elevation: buttonElevation,
          ),
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
            iconSize: iconSize ?? 12,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
          ),
          dropdownStyleData: DropdownStyleData(
            //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
            maxHeight: dropdownHeight ?? 200,
            width: dropdownWidth,
            padding: dropdownPadding,
            decoration: dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.p2.sw),
                ),
            elevation: dropdownElevation ?? 8,
            //Null or Offset(0, 0) will open just under the button. You can edit as you want.
            offset: offset,
            scrollbarTheme: scrollbarRadius != null
                ? ScrollbarThemeData(
                    radius: scrollbarRadius ?? const Radius.circular(40),
                    thickness: scrollbarThickness != null
                        ? MaterialStateProperty.all<double>(scrollbarThickness!)
                        : null,
                    thumbVisibility: scrollbarAlwaysShow != null
                        ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                        : null,
                  )
                : null,
          ),
          menuItemStyleData: MenuItemStyleData(
            // height: itemHeight ?? 40,
            padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
