import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:daily_dairy_diary/widgets/common_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppDropDownFiled<T> extends StatefulWidget {
  const AppDropDownFiled({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.validator,
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
    this.label,
    super.key,
  });
  final String hint;
  final T? value;
  final List<T> dropdownItems;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T?>? validator;
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
  final String? label;

  @override
  State<AppDropDownFiled<T>> createState() => AppDropDownFiledState<T>();
}

class AppDropDownFiledState<T> extends State<AppDropDownFiled<T>> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);
  late final FocusNode textFieldFocus = FocusNode()
    ..addListener(() {
      _textFiledIsFocused.value = textFieldFocus.hasFocus;
    });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.p1.sh),
      child: ValueListenableBuilder<bool>(
        valueListenable: _textFiledIsFocused,
        builder: (context, value, child) => Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p1_5.sh),
                child: Text(
                  widget.label ?? '',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.textFieldLabelStyle(),
                ),
              ),
              Box.gapH1,
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2<T>(
                  focusNode: textFieldFocus,
                  isExpanded: true,
                  decoration: buildInputDecoration(value),
                  hint: Container(
                    alignment: widget.hintAlignment,
                    child: Text(
                      widget.hint,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: CustomTextStyle.textFieldTitleStyle(),
                    ),
                  ),
                  style: CustomTextStyle.textFieldTitleStyle(),
                  value: widget.value,
                  items: widget.dropdownItems.map((item) {
                    if (item is Inventory) {
                      return DropdownMenuItem<T>(
                        value: item,
                        child: Container(
                          alignment: widget.valueAlignment,
                          child: Text(
                            item.type ?? '',
                            style: CustomTextStyle.textFieldTitleStyle(),
                          ),
                        ),
                      );
                    }
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Container(
                        alignment: widget.valueAlignment,
                        child: Text(
                          item as String,
                        ),
                      ),
                    );
                  }).toList(),
                  validator: (value) => widget.validator != null
                      ? (value is Inventory)
                          ? widget.validator!(value)
                          : widget.validator!(null)
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: widget.onChanged,
                  selectedItemBuilder: widget.selectedItemBuilder,
                  buttonStyleData: ButtonStyleData(
                    // height: buttonHeight ?? 40,
                    // width: buttonWidth ?? 140,
                    padding: widget.buttonPadding ??
                        EdgeInsets.only(right: Sizes.p1.sw),
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
                    icon: widget.icon ??
                        (value
                            ? const Icon(Icons.keyboard_arrow_up_rounded)
                            : const Icon(Icons.keyboard_arrow_down_rounded)),
                    iconSize: widget.iconSize ?? Sizes.p6.sw,
                    iconEnabledColor: widget.iconEnabledColor ??
                        (value
                            ? AppColors.darkPurpleColor
                            : AppColors.thinPurpleColor),
                    iconDisabledColor: widget.iconDisabledColor,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
                    maxHeight: widget.dropdownHeight ?? Sizes.p200,
                    width: widget.dropdownWidth,
                    padding: widget.dropdownPadding,
                    decoration: widget.dropdownDecoration ??
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.p2.sw),
                          color: AppColors.alphaPurpleColor,
                        ),
                    elevation: widget.dropdownElevation ?? Sizes.p8.toInt(),
                    //Null or Offset(0, 0) will open just under the button. You can edit as you want.
                    offset: widget.offset,
                    scrollbarTheme: widget.scrollbarRadius != null
                        ? ScrollbarThemeData(
                            radius: widget.scrollbarRadius ??
                                const Radius.circular(Sizes.p40),
                            thickness: widget.scrollbarThickness != null
                                ? MaterialStateProperty.all<double>(
                                    widget.scrollbarThickness!)
                                : null,
                            thumbVisibility: widget.scrollbarAlwaysShow != null
                                ? MaterialStateProperty.all<bool>(
                                    widget.scrollbarAlwaysShow!)
                                : null,
                          )
                        : null,
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    // height: itemHeight ?? 40,
                    padding: widget.itemPadding ??
                        const EdgeInsets.only(
                            left: Sizes.p14, right: Sizes.p14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(bool value) {
    return InputDecoration(
      // errorText: errorText,
      errorStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: Theme.of(context).colorScheme.error),
      filled: true,
      fillColor: value ? AppColors.lightPurpleColor : AppColors.whiteColor,
      // labelText: label,
      border: buildBorder(AppColors.lightPurpleColor),
      enabledBorder: buildBorder(AppColors.lightPurpleColor),
      focusedBorder: buildBorder(AppColors.lightPurpleColor),
      disabledBorder: buildBorder(AppColors.grayColor),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Sizes.p2.sw,
        vertical: Sizes.p2.sh,
      ),
    );
  }
}
