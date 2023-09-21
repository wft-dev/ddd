import 'package:daily_dairy_diary/delegate/search.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/filter_date_controller.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:daily_dairy_diary/provider/providers.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constant/strings.dart';
import '../widgets/all_widgets.dart';

class Report extends ConsumerStatefulWidget {
  const Report({super.key});

  @override
  ConsumerState<Report> createState() => ReportState();
}

class ReportState extends ConsumerState<Report> {
  late final ValueNotifier<List<Product?>> selectedEvents;
  bool isRefreshing = false;
  int selectedIndex = Sizes.pIntN1;
  String selectedFilterData = ProductFilterType.all.name.capitalizeFirst();

  @override
  void initState() {
    super.initState();
    selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppBar(
      barTitle: Strings.report,
      barActions: [
        buildSearchIconButton(),
      ],
      child: getBody(),
    );
  }

  // This search [IconButton] display on app bar and used for searching the products.
  buildSearchIconButton() {
    return Padding(
      padding: EdgeInsets.only(right: Sizes.p5.sw),
      child: IconButton(
        onPressed: () {
          // method to show the search bar
          showSearch(
              context: context,
              // delegate to customize the search bar
              delegate:
                  CustomSearchDelegate(productList: selectedEvents.value));
        },
        icon: Icon(
          Icons.search,
          size: Sizes.p35,
          color: AppColors.darkPurpleColor,
        ),
      ),
    );
  }

  // This is used to display all widgets.
  Widget getBody() {
    ref.listen<AsyncValue>(productFilterControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final List<Product?> productList = result;
            selectedEvents.value = productList;
          },
        );
      }
    });
    ref.watch(productFilterWithDateProvider(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.alphaPurpleColor,
              borderRadius: BorderRadius.all(Radius.circular(Sizes.p12.sw)),
            ),
            padding: EdgeInsets.symmetric(horizontal: Sizes.p3.sw),
            child: Text(
              textAlign: TextAlign.center,
              selectedFilterData,
              style: CustomTextStyle.textFieldLabelStyle()
                  .copyWith(fontSize: Sizes.p4_5.sw),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<Product?>>(
            valueListenable: selectedEvents,
            builder: (context, value, _) {
              return RefreshIndicator(
                  color: AppColors.darkPurpleColor,
                  onRefresh: (() async {
                    setState(() {
                      isRefreshing = true;
                    });
                    return ref
                        .refresh(productFilterControllerProvider.notifier);
                  }),
                  child: ProductList(value));
            },
          ),
        ),
        buildFilterTypeButton(),
        Box.gapH4,
      ],
    );
  }

  // This is used display fitter type buttons.
  Widget buildFilterTypeButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: Sizes.p5.sh,
        minHeight: Sizes.p5.sh,
      ),
      child: Container(
        height: Sizes.p5.sh,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPurpleColor,
              blurRadius: Sizes.p3,
              spreadRadius: Sizes.p1,
              offset: const Offset(
                Sizes.p0,
                Sizes.p2,
              ),
            ),
          ],
          color: AppColors.alphaPurpleColor,
          shape: BoxShape.rectangle,
          border: Border.all(
            width: Sizes.p02.sw,
            color: AppColors.alphaPurpleColor,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.p4.sw),
              bottomLeft: Radius.circular(Sizes.p4.sw),
              topRight: Radius.circular(Sizes.p4.sw),
              bottomRight: Radius.circular(Sizes.p4.sw)),
        ),
        margin: EdgeInsets.only(
          left: Sizes.p2.sw,
          right: Sizes.p2.sw,
        ),
        padding: EdgeInsets.only(
          // top: Sizes.p01.sh,
          // bottom: Sizes.p01.sh,
          left: Sizes.p02.sw,
          right: Sizes.p02.sw,
        ),
        child: AppSegmentButton(
          labels: enumToStringList(ProductFilterType.values),
          selectedIndex: selectedIndex,
          onIndexChanged: handleAppSegmentButtonClick,
        ),
      ),
    );
  }

  // [AppSegmentButton] selection for all [ProductFilterType].
  handleAppSegmentButtonClick(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == Sizes.p0.toInt()) {
      setState(() {
        selectedFilterData =
            ProductFilterType.values[index].name.capitalizeFirst();
      });
      ref.invalidate(productFilterControllerProvider);
    } else if (index == Sizes.p1.toInt()) {
      buildWeeksPicker();
    } else if (index == Sizes.p2.toInt()) {
      buildMonthPicker();
    } else if (index == Sizes.p3.toInt()) {
      buildYearPicker();
    } else if (index == Sizes.p4.toInt()) {
      buildDateRangePicker();
    }
  }

  // This is used to display week [AppPicker].
  void buildWeeksPicker() {
    return AppPicker(
        title: ProductFilterType.week.name.capitalizeFirst(),
        pickerList: weeks,
        onConfirm: (selectedText) {
          setState(() {
            selectedFilterData = selectedText;
          });
          int selectedIndex = weeks.indexOf(selectedText) + Sizes.pInt1;
          ref.read(filterDateControllerProvider.notifier).updateFilterType(
              ProductFilterType.week,
              week: (selectedIndex * Sizes.p7.toInt() - Sizes.pInt1));
        }).showPicker(context);
  }

  // This is used to display month [AppPicker].
  void buildMonthPicker() {
    return AppPicker(
        title: ProductFilterType.month.name.capitalizeFirst(),
        pickerList: sortedMonths(),
        onConfirm: (selectedText) {
          setState(() {
            selectedFilterData = selectedText;
          });
          int selectedIndex = months.indexOf(selectedText) + Sizes.pInt1;
          ref
              .read(filterDateControllerProvider.notifier)
              .updateFilterType(ProductFilterType.month, month: selectedIndex);
        }).showPicker(context);
  }

// This is used to display year [AppPicker].
  void buildYearPicker() {
    return AppPicker(
        title: ProductFilterType.year.name.capitalizeFirst(),
        pickerList: years,
        onConfirm: (selectedText) {
          setState(() {
            selectedFilterData = selectedText;
          });
          ref.read(filterDateControllerProvider.notifier).updateFilterType(
              ProductFilterType.year,
              year: selectedText.parseInt());
        }).showPicker(context);
  }

  // This is used to display range [DateTimeRangePicker].
  void buildDateRangePicker() {
    return DateTimeRangePicker(
        initialStartTime: DateTime.now(),
        initialEndTime: DateTime.now().add(const Duration(days: 1)),
        mode: DateTimeRangePickerMode.date,
        onConfirm: (start, end) {
          setState(() {
            selectedFilterData =
                '${FormatDate.dateToString(start)} - ${FormatDate.dateToString(end)}';
          });
          ref.read(filterDateControllerProvider.notifier).updateFilterType(
              ProductFilterType.range,
              startDateRange: start,
              endDateRange: end);
        }).showPicker(context);
  }
}
