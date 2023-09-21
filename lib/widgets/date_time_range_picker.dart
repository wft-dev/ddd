import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

typedef PickerConfirmCallback = void Function(DateTime start, DateTime end);

enum DateTimeRangePickerMode {
  time,
  date,
  dateAndTime,
}

class DateTimeRangePicker {
  final String startText;
  final String endText;
  final String doneText;
  final String cancelText;
  final bool use24hFormat;
  final DateTimeRangePickerMode mode;

  DateTime? initialStartTime;
  DateTime? initialEndTime;
  DateTime? minimumTime;
  DateTime? maximumTime;

  final VoidCallback? onCancel;
  final PickerConfirmCallback? onConfirm;

  final int interval;

  DateTimeRangePicker({
    Key? key,
    this.startText = Strings.startDate,
    this.endText = Strings.endDate,
    this.doneText = Strings.done,
    this.cancelText = Strings.cancel,
    this.mode = DateTimeRangePickerMode.dateAndTime,
    this.interval = 15,
    this.use24hFormat = false,
    this.minimumTime,
    this.maximumTime,
    this.initialStartTime,
    this.initialEndTime,
    this.onCancel,
    this.onConfirm,
  });

  void showPicker(BuildContext context) {
    initialStartTime ??= DateTime.now();

    // Remove minutes and seconds to prevent exception of cupertino picker: initial minute is not divisible by minute interval
    initialStartTime = initialStartTime!.subtract(Duration(
        minutes: initialStartTime!.minute, seconds: initialStartTime!.second));

    initialEndTime ??= initialStartTime!.add(Duration(
        days: mode == DateTimeRangePickerMode.time ? 0 : 1,
        hours: mode == DateTimeRangePickerMode.time ? 2 : 0));

    initialEndTime = initialEndTime!.subtract(Duration(
        minutes: initialEndTime!.minute, seconds: initialEndTime!.second));

    if (minimumTime != null) {
      minimumTime = minimumTime!.subtract(
          Duration(minutes: minimumTime!.minute, seconds: minimumTime!.second));
    }

    if (maximumTime != null) {
      maximumTime = maximumTime!.subtract(
          Duration(minutes: maximumTime!.minute, seconds: maximumTime!.second));
    }

    var pickerMode = CupertinoDatePickerMode.dateAndTime;

    switch (mode) {
      case DateTimeRangePickerMode.date:
        {
          pickerMode = CupertinoDatePickerMode.date;
        }
        break;

      case DateTimeRangePickerMode.time:
        {
          pickerMode = CupertinoDatePickerMode.time;
        }
        break;

      default:
        {
          pickerMode = CupertinoDatePickerMode.dateAndTime;
        }
        break;
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            widthFactor: Sizes.p1,
            heightFactor: Sizes.p08,
            child: PickerWidget([
              Tab(text: startText),
              Tab(text: endText),
            ],
                initialStartTime,
                initialEndTime,
                interval,
                onCancel,
                onConfirm,
                pickerMode,
                doneText,
                cancelText,
                minimumTime,
                maximumTime,
                use24hFormat),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final int _interval;
  final VoidCallback? _onCancel;
  final PickerConfirmCallback? _onConfirm;

  final DateTime? _initStart;
  final DateTime? _initEnd;
  final CupertinoDatePickerMode _mode;

  final String _doneText;
  final String _cancelText;
  final DateTime? _minimumTime;
  final DateTime? _maximumTime;
  final bool _use24hFormat;

  const PickerWidget(
      this._tabs,
      this._initStart,
      this._initEnd,
      this._interval,
      this._onCancel,
      this._onConfirm,
      this._mode,
      this._doneText,
      this._cancelText,
      this._minimumTime,
      this._maximumTime,
      this._use24hFormat,
      {Key? key})
      : super(key: key);

  @override
  PickerWidgetState createState() => PickerWidgetState();
}

class PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    _start = widget._initStart;
    _end = widget._initEnd;

    _tabController = TabController(vsync: this, length: widget._tabs.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.alphaPurpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightPurpleColor,
        title: TabBar(
          controller: _tabController,
          tabs: widget._tabs,
          labelStyle: CustomTextStyle.textFieldLabelStyle()
              .copyWith(fontSize: Sizes.p4.sw),
          labelColor: AppColors.darkPurpleColor,
          indicatorColor: AppColors.darkPurpleColor,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.alphaPurpleColor,
              height: Sizes.p25.sh,
              alignment: Alignment.topCenter,
              child: TabBarView(
                controller: _tabController,
                children: widget._tabs.map((Tab tab) {
                  return Column(children: [
                    // Container(
                    //   alignment: Alignment.center,
                    //   width: ResponsiveAppUtil.width,
                    //   height: Sizes.p6.sh,
                    //   margin: EdgeInsets.symmetric(
                    //       horizontal: Sizes.p4.sw, vertical: Sizes.p2.sh),
                    //   color: AppColors.dimPurpleColor,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: Sizes.p8, vertical: Sizes.p4),
                    //     child: Text(
                    //       tab.text == widget._tabs.first.text
                    //           ? FormatDate.dateToString(_start!)
                    //           : FormatDate.dateToString(_end!),
                    //       textAlign: TextAlign.center,
                    //       style: CustomTextStyle.textFieldLabelStyle()
                    //           .copyWith(fontSize: Sizes.p4.sw),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle:
                                CustomTextStyle.textFieldLabelStyle()
                                    .copyWith(fontSize: Sizes.p4.sw),
                          ),
                        ),
                        child: CupertinoDatePicker(
                          mode: widget._mode,
                          use24hFormat: widget._use24hFormat,
                          minuteInterval: widget._interval,
                          minimumDate: widget._minimumTime != null &&
                                  tab.text == widget._tabs.first.text
                              ? widget._minimumTime
                              : null,
                          maximumDate: widget._maximumTime != null &&
                                  tab.text == widget._tabs.last.text
                              ? widget._maximumTime
                              : null,
                          initialDateTime: tab.text == widget._tabs.first.text
                              ? _start
                              : _end,
                          onDateTimeChanged: (DateTime newDateTime) {
                            if (tab.text == widget._tabs.first.text) {
                              setState(() {
                                _start = newDateTime;
                              });
                            } else {
                              setState(() {
                                _end = newDateTime;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: Sizes.p1.sh),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: AppButton(
                      width: Sizes.p20.sw,
                      height: Sizes.p5.sh,
                      text: widget._cancelText,
                      onPress: () {
                        Navigator.pop(context);
                        if (widget._onCancel != null) {
                          widget._onCancel!();
                        }
                      },
                    ),
                  ),
                  Box.gapW2,
                  Flexible(
                    child: AppButton(
                      width: Sizes.p20.sw,
                      height: Sizes.p5.sh,
                      text: widget._doneText,
                      onPress: () {
                        if (widget._onConfirm != null) {
                          if (_end!.compareTo(_start!) < Sizes.p0.toInt()) {
                            showAlertActionDialog(
                              context: context,
                              title: Strings.endDate,
                              content: Strings.endDateNoLess,
                              onYesPress: () {},
                            );
                            return;
                          }
                          Navigator.of(context).pop();
                          widget._onConfirm!(_start!, _end!);
                        }
                      },
                    ),
                  ),
                  Box.gapW2,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
