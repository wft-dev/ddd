import 'dart:async';

import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';

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

  // Show date picker.
  Future<void> _selectDate(BuildContext context) async {
    final ThemeData customDatePickerTheme = ThemeData(
      colorScheme: ColorScheme.light(
          onPrimary: AppColors.whiteColor, onBackground: AppColors.whiteColor),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: AppColors.lightPurpleColor,
        backgroundColor: AppColors.alphaPurpleColor,
        headerForegroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
      ),
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: customDatePickerTheme,
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate?.call(pickedDate);
    }
  }

  // Show time picker.
  Future<void> _selectTime(BuildContext context) async {
    final ThemeData customTimePickerTheme = ThemeData(
      colorScheme: ColorScheme.light(
          onPrimary: AppColors.whiteColor, onBackground: AppColors.whiteColor),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.alphaPurpleColor,
      ),
    );
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: customTimePickerTheme,
          child: child!,
        );
      },
    );
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
          flex: Sizes.p5.toInt(),
          child: InputDropdown(
            labelText: dateLabelText,
            valueText: FormatDate.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
        Box.gapW2,
        Expanded(
          flex: Sizes.p4.toInt(),
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
