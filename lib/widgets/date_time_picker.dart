import 'dart:async';

import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/utils/format_Date.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
    required this.dateLabelText,
    required this.timeLabelText,
    required this.selectedDate,
    required this.selectedTime,
    this.onSelectedDate,
    this.onSelectedTime,
  }) : super(key: key);

  final String dateLabelText;
  final String timeLabelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<TimeOfDay>? onSelectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate?.call(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime?.call(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = CustomTextStyle.textFieldTitleStyle();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          // flex: Sizes.p5.toInt(),
          child: InputDropdown(
            labelText: dateLabelText,
            valueText: FormatDate.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        Box.gapW2,
        Expanded(
          // flex: Sizes.p4.toInt(),
          child: InputDropdown(
            labelText: timeLabelText,
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}
