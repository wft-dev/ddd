import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/common_utils.dart';

class AppTextFormField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.p1_5.sh),
      child: TextFormField(
          onChanged: onChanged,
          onEditingComplete: onEditingCompleted,
          autofocus: autoFocus,
          minLines: isMultiline ? 4 : 1,
          maxLines: isMultiline ? null : 1,
          onTap: onTap,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscure,
          keyboardType: keyboardType,
          controller: controller,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            labelText: label,
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
              horizontal: Sizes.p4.sw,
              vertical: Sizes.p2.sh,
            ),
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.p4_5.sw,
            fontWeight: FontWeight.w500,
          ),
          validator: (value) => validator != null ? validator!(value) : null),
    );
  }
}
