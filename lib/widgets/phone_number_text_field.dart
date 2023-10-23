import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/common_utils.dart';

// [PhoneNumberTextField] class is used to display the [InternationalPhoneNumberInput].
class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<PhoneNumber>? onInputChanged;
  final bool isMultiline;
  final bool autoFocus;
  final bool enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final FocusNode? focus;
  final Color? borderColor;
  final Color? fillColor;
  final String? countyCode;

  const PhoneNumberTextField({
    Key? key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.onTap,
    this.isMultiline = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.errorText,
    this.label,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.textInputAction,
    this.onInputChanged,
    this.focus,
    this.borderColor,
    this.fillColor,
    this.countyCode,
  }) : super(key: key);

  @override
  State<PhoneNumberTextField> createState() => PhoneNumberTextFieldState();
}

class PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);
  PhoneNumber phoneNumber = PhoneNumber(isoCode: Strings.countyCode);
  FocusNode? focus = FocusNode();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.focus != null) {
      focus = widget.focus;
    }

    focus?.addListener(() {
      _textFiledIsFocused.value = focus!.hasFocus;
    });
  }

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber = PhoneNumber(
        phoneNumber: widget.controller!.text,
        isoCode: (widget.countyCode ?? Strings.countyCode));
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
                padding: EdgeInsets.symmetric(horizontal: Sizes.p3.sw),
                child: Text(
                  widget.label ?? '',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.textFieldLabelStyle(),
                ),
              ),
              Box.gapH1,
              Container(
                decoration: buildBoxDecoration(
                  borderColor: widget.borderColor == null
                      ? AppColors.alphaPurpleColor
                      : AppColors.whiteColor,
                  fillColor: widget.borderColor == null
                      ? AppColors.alphaPurpleColor
                      : AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: Sizes.p3.sw),
                  child: InternationalPhoneNumberInput(
                    spaceBetweenSelectorAndTextField: Sizes.p02.sw,
                    initialValue: phoneNumber,
                    focusNode: focus,
                    autoFocus: widget.autoFocus,
                    keyboardType: widget.keyboardType,
                    textFieldController: widget.controller,
                    keyboardAction: widget.textInputAction,
                    textStyle: CustomTextStyle.textFieldTitleStyle(),
                    isEnabled: widget.enabled,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    ignoreBlank: true, // Allow empty input
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      // Change background color here
                    ),
                    selectorTextStyle: CustomTextStyle.textFieldTitleStyle(),
                    inputDecoration: buildInputDecoration(value),
                    searchBoxDecoration: buildSearchDecoration(value),
                    onInputChanged: widget.onInputChanged,
                    // validator: (value) {
                    //   widget.validator != null
                    //       ? widget.validator!(value)
                    //       : null;
                    //   return null;
                    // },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // [InputDecoration] is used for search field.
  InputDecoration buildSearchDecoration(bool value) {
    return InputDecoration(
      hintText: Strings.search,
      border: buildBorder(AppColors.lightPurpleColor),
      enabledBorder: buildBorder(AppColors.lightPurpleColor),
      focusedBorder: buildBorder(AppColors.lightPurpleColor),
      disabledBorder: buildBorder(AppColors.grayColor),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: Sizes.p4.sw,
        vertical: Sizes.p1_4.sh,
      ),
    );
  }

  // [InputDecoration] is used for field.
  InputDecoration buildInputDecoration(bool value) {
    return InputDecoration(
      errorText: widget.errorText,
      prefixIcon: widget.prefix,
      suffixIcon: !widget.obscure
          ? widget.suffix
          : GestureDetector(
              onTap: () {
                toggleVisibility();
              },
              child: Icon(
                color: focus!.hasFocus
                    ? AppColors.darkPurpleColor
                    : AppColors.thinPurpleColor,
                size: Sizes.p5.sw,
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
      filled: true,
      fillColor: value ? AppColors.lightPurpleColor : AppColors.whiteColor,
      // labelText: label,
      border: buildBorder(AppColors.lightPurpleColor),
      enabledBorder: buildBorder(AppColors.lightPurpleColor),
      focusedBorder: buildBorder(AppColors.lightPurpleColor),
      disabledBorder: buildBorder(AppColors.grayColor),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: Sizes.p4.sw,
        vertical: Sizes.p1_4.sh,
      ),
    );
  }
}
