import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/models/event.dart';
import 'package:daily_dairy_diary/models/user.dart';
import 'package:daily_dairy_diary/provider/calendar_event_provider.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/update_user_controller.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  late final ValueNotifier<List<Product>> selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Product>> events = {};
  Map<String, List<Product>> productByType = {};

  int activeButtonIndex = Sizes.pIntN1;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    ref.read(getCalendarEventProvider);
    selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  // [List] of products.
  List<Product> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  // Set selected day.
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        activeButtonIndex = Sizes.pIntN1;
      });
      selectedEvents.value = getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(updateUserControllerProvider
        .select((user) => user.whenData((value) => value.name)));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        isCenterTitle: false,
        userName: userName.value,
        backgroundColor: AppColors.whiteColor,
        title: Strings.dashboard,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Sizes.p5.sw),
            child: IconButton(
              color: AppColors.alphaPurpleColor,
              icon: Image.asset(AppImages.addMoreBtnImage),
              iconSize: Sizes.p40,
              onPressed: () {
                AddProductRoute().push(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: ResponsiveAppUtil.height,
        // width: ResponsiveAppUtil.width,
        color: AppColors.alphaPurpleColor,
        child: getBody(),
      ),
    );
  }

  // This is used for display all widgets.
  Widget getBody() {
    events = ref.watch(getCalendarEventProvider);
    if (activeButtonIndex == Sizes.pIntN1) {
      selectedEvents.value = getEventsForDay(_selectedDay!);
    }
    return Container(
      height: ResponsiveAppUtil.height * Sizes.p01.sh,
      // width: ResponsiveAppUtil.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(Sizes.p12.sw)),
      ),
      padding: EdgeInsets.symmetric(vertical: Sizes.p01.sh),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p6.sw),
              child: Column(
                children: [
                  buildCalendar(),
                  Box.gapH2,
                  buildProductList(),
                ],
              ),
            ),
            buildProductType(),
            Box.gapH2,
            buildListOfProducts(),
          ],
        ),
      ),
    );
  }

  //[List] of all product type button like milk, bread etc.
  Widget buildProductType() {
    productByType = ref.watch(getProductByTypeProvider);
    final productKeyList = productByType.keys.toList();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: Sizes.p6.sh,
        minHeight: Sizes.p5.sh,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: Sizes.p8.sw,
          right: Sizes.p8.sw,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productKeyList.length,
          itemBuilder: (context, index) {
            String typeName = productKeyList[index];
            List<Product> productList = productByType[typeName]!;
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.p01.sh, horizontal: Sizes.p2.sw),
              child: AppRectangularButton(
                index: index,
                height: Sizes.p6.sh,
                text: typeName,
                value: productList.length.toString(),
                onPress: (int index) {
                  setState(() {
                    activeButtonIndex = index;
                    selectedEvents.value = productList;
                  });
                },
                activeIndex: activeButtonIndex,
              ),
            );
          },
        ),
      ),
    );
  }

  // Show list of products based on selected date.
  Widget buildListOfProducts() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: Sizes.p20.sh,
        minHeight: Sizes.p10.sh,
      ),
      child: ValueListenableBuilder<List<Product>>(
        valueListenable: selectedEvents,
        builder: (context, value, _) {
          return ProductList(value);
        },
      ),
    );
  }

  // This [Container] is display product list and view all.
  // If you click on view all button, then it is going to report screen.
  Container buildProductList() {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: Sizes.p01.sh, horizontal: Sizes.p8.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.productList,
            style: CustomTextStyle.titleStyle().copyWith(
                fontSize: Sizes.p4.sw, fontWeight: Fonts.fontWeightBold),
          ),
          TextButton(
            child: Text(
              Strings.viewAll,
              style: CustomTextStyle.titleStyle().copyWith(
                  fontSize: Sizes.p3.sw, fontWeight: Fonts.fontWeightBold),
            ),
            onPressed: () => const ReportRoute().push(context),
          ),
        ],
      ),
    );
  }

  // This is used for display [TableCalendar].
  Container buildCalendar() {
    return Container(
      padding: EdgeInsets.only(bottom: Sizes.p4.sh),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Sizes.p8.sw),
          bottomRight: Radius.circular(Sizes.p8.sw),
        ),
        // color: AppColors.alphaPurpleColor,
        // shape: BoxShape.rectangle,
        // borderRadius: BorderRadius.circular(Sizes.p6.sw),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.whiteColor, AppColors.alphaPurpleColor],
        ),
      ),
      child: TableCalendar<Product>(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: calendarFormat,
        eventLoader: getEventsForDay,
        rowHeight: Sizes.p7.sh,
        daysOfWeekHeight: Sizes.p8.sh,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(left: Sizes.p4.sw, right: Sizes.p4.sw),
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: CustomTextStyle.titleStyle().copyWith(
              fontSize: Sizes.p5.sw, fontWeight: Fonts.fontWeightBold),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: AppColors
                .darkPurpleColor, // Change the color of the left chevron here
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: AppColors
                .darkPurpleColor, // Change the color of the chevron_right chevron here
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(
            color: AppColors.alphaPurpleColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.p8.sw),
              topRight: Radius.circular(Sizes.p8.sw),
            ),
          ),
        ),
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.only(
              top: Sizes.p3, bottom: Sizes.p3, left: Sizes.p2, right: Sizes.p2),
          markersMaxCount: Sizes.pInt1,
          markersAnchor: Sizes.p1,
          todayTextStyle: CustomTextStyle.calendarTitleStyle().copyWith(
              color: AppColors.whiteColor, fontWeight: Fonts.fontWeightMedium),
          defaultTextStyle: CustomTextStyle.calendarTitleStyle()
              .copyWith(fontWeight: Fonts.fontWeightMedium),
          selectedTextStyle: CustomTextStyle.calendarTitleStyle().copyWith(
              color: AppColors.whiteColor, fontWeight: Fonts.fontWeightMedium),
          weekendTextStyle: CustomTextStyle.calendarTitleStyle()
              .copyWith(fontWeight: Fonts.fontWeightNormal),
          rowDecoration: BoxDecoration(
            color: AppColors.alphaPurpleColor,
          ),
          todayDecoration:
              buildCalendarBoxDecoration(color: AppColors.darkPurpleColor),
          selectedDecoration:
              buildCalendarBoxDecoration(color: AppColors.pinkColor),
          disabledDecoration:
              buildCalendarBoxDecoration(color: AppColors.pinkColor),
          weekendDecoration: buildCalendarBoxDecoration(),
          defaultDecoration: buildCalendarBoxDecoration(),
          holidayDecoration: buildCalendarBoxDecoration(),
          outsideDecoration: buildCalendarBoxDecoration(),
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
            final text = FormatDate.dayOfWeek(day);
            return Center(
              child: Container(
                padding: EdgeInsets.only(top: Sizes.p3.sh),
                child: Text(
                  text[0],
                  style: CustomTextStyle.titleStyle()
                      .copyWith(fontSize: Sizes.p4.sw),
                ),
              ),
            );
          },
          singleMarkerBuilder: (context, day, _) {
            return Padding(
              padding: const EdgeInsets.only(left: Sizes.p1),
              child: Container(
                width: Sizes.p5.sw,
                height: Sizes.p06.sh,
                decoration: BoxDecoration(
                    color: (_selectedDay == day ||
                            day == FormatDate.getDateUtc(kToday))
                        ? AppColors.whiteColor
                        : AppColors.darkPurpleColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Sizes.p10.sh))),
              ),
            );
          },
        ),
      ),
    );
  }

  // [BoxDecoration] for calendar day rows.
  BoxDecoration buildCalendarBoxDecoration({Color? color}) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: color,
      borderRadius: BorderRadius.circular(Sizes.p3.sw),
    );
  }
}
