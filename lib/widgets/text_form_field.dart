import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Function? validator;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isMultiline;
  final bool autoFocus;
  final bool enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputAction? textInputAction;

  const AppTextFormField(
      {Key? key,
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
      this.onChanged})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);
  late final FocusNode textFieldFocus = FocusNode()
    ..addListener(() {
      _textFiledIsFocused.value = textFieldFocus.hasFocus;
    });

  bool obscureText = true;

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

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
              TextFormField(
                  focusNode: textFieldFocus,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingCompleted,
                  autofocus: widget.autoFocus,
                  minLines: widget.isMultiline ? Sizes.pInt4 : Sizes.pInt1,
                  maxLines: widget.isMultiline ? null : Sizes.pInt1,
                  onTap: widget.onTap,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  obscureText: !obscureText ? obscureText : widget.obscure,
                  keyboardType: widget.keyboardType,
                  controller: widget.controller,
                  textInputAction: widget.textInputAction,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(value),
                  style: CustomTextStyle.textFieldTitleStyle(),
                  validator: (value) => widget.validator != null
                      ? widget.validator!(value)
                      : null),
            ],
          ),
        ),
      ),
    );
  }

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
                color: textFieldFocus.hasFocus
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
      contentPadding: EdgeInsets.symmetric(
        horizontal: Sizes.p4.sw,
        vertical: Sizes.p1.sh,
      ),
    );
  }
}
