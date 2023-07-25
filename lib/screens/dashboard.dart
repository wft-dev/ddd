import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:daily_dairy_diary/models/event.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../router/routes.dart';
import '../widgets/all_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => DashboardState();
}

class DashboardState extends ConsumerState<Dashboard> {
  late final ValueNotifier<List<Event>> selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  List<Event> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      selectedEvents.value = getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.dashboard),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(400, 16.0),
            ),
          ),
        ),
        body: getBody());
  }

  Widget getBody() {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCalendar(),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: selectedEvents,
              builder: (context, value, _) {
                return Container();
              },
            ),
          ),
          buildSettingButton(),
        ],
      ),
    );
  }

  Container buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Sizes.p6.sw),
      ),
      // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      child: TableCalendar<Event>(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: calendarFormat,
        eventLoader: getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          markersMaxCount: 1,
          markersAnchor: 1,
          outsideDaysVisible: false,
          markerDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Sizes.p4.sw),
          ),
          todayDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Sizes.p1.sw),
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Sizes.p1.sw),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Sizes.p1.sw),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Sizes.p1.sw),
          ),
        ),
        onDaySelected: onDaySelected,
        // onRangeSelected: _onRangeSelected,
        onFormatChanged: (format) {
          if (calendarFormat != format) {
            setState(() {
              calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final text =
                DateFormat('E').format(day); //DateFormat.E().format(day);
            return Center(
              child: Text(
                text[0],
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
          singleMarkerBuilder: (context, day, _) {
            return Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Container(
                width: Sizes.p4.sw,
                height: Sizes.p1.sh,
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            );
          },
          // markerBuilder: (BuildContext context, date, events) {
          //   if (events.isEmpty) return const SizedBox();
          //   return ListView.builder(
          //       shrinkWrap: true,
          //       scrollDirection: Axis.horizontal,
          //       itemCount: events.length,
          //       itemBuilder: (context, index) {
          //         return Container(
          //           margin: const EdgeInsets.only(top: 20),
          //           padding: const EdgeInsets.all(1),
          //           child: Container(
          //             height: 7, // for vertical axis
          //             width: 5, //for horizontal axis
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: Colors.primaries[
          //                     Random().nextInt(Colors.primaries.length)]),
          //           ),
          //         );
          //       });
          // },
        ),
      ),
    );
  }

  AppButton buildSettingButton() {
    return AppButton(
      text: Strings.setting,
      onPress: () async {
        const SettingProductRoute().go(context);
      },
    );
  }
}
