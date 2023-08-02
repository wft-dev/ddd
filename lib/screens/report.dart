import 'package:daily_dairy_diary/api_service/queries.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/delegate/search.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/provider/filter_date_controller.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:daily_dairy_diary/provider/providers.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import '../widgets/all_widgets.dart';

// An enum representing the filter type
enum ProductFilterType { week, month, year, dateRange }

class Report extends ConsumerStatefulWidget {
  const Report({super.key});

  @override
  ConsumerState<Report> createState() => ReportState();
}

class ReportState extends ConsumerState<Report> {
  late final ValueNotifier<List<Product?>> selectedEvents;
  bool isRefreshing = false;

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
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.report),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate(
                        productList: selectedEvents.value));
              },
              icon: const Icon(Icons.search),
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(400, 16.0),
            ),
          ),
        ),
        body: getBody());
  }

  Widget getBody() {
    ref.listen<AsyncValue>(productFilterControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);

      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData(
          (result) async {
            final List<Product?> productList = result;
            if (productList.isNotEmpty) {
              selectedEvents.value = productList;
            }
          },
        );
      }
    });
    ref.watch(productFilterWithDateProvider);

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAllButton(),
              buildWeekButton(),
              buildMonthButton(),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Product?>>(
              valueListenable: selectedEvents,
              builder: (context, value, _) {
                return RefreshIndicator(
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
        ],
      ),
    );
  }

  AppButton buildAllButton() {
    return AppButton(
      width: 80,
      text: Strings.all,
      onPress: () async {
        ref.invalidate(productFilterControllerProvider);
      },
    );
  }

  AppButton buildWeekButton() {
    return AppButton(
      width: 80,
      text: Strings.week,
      onPress: () async {
        // productListWithFilterType(ProductFilterType.week);
        ref
            .read(filterDateControllerProvider.notifier)
            .updateFilterType(ProductFilterType.week);
      },
    );
  }

  AppButton buildMonthButton() {
    return AppButton(
      width: 80,
      text: Strings.month,
      onPress: () async {
        // productListWithFilterType(ProductFilterType.month);
        ref
            .read(filterDateControllerProvider.notifier)
            .updateFilterType(ProductFilterType.month, 5);
      },
    );
  }
}
