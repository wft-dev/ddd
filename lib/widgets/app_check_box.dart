import 'package:flutter/material.dart';

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
    return CheckboxListTile(
      title: Text(widget.title ?? ''),
      checkColor: Colors.white,
      activeColor: Colors.deepPurple,
      value: widget.listTileCheckBox,
      onChanged: (val) {
        setState(() {
          isSelected = val!;
          widget.onChange(val);
        });
      },
    );
  }
}
