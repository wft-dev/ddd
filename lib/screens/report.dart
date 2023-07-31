import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/provider/calendar_event_provider.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import '../router/routes.dart';
import '../widgets/all_widgets.dart';

class Report extends ConsumerStatefulWidget {
  const Report({super.key});

  @override
  ConsumerState<Report> createState() => ReportState();
}

class ReportState extends ConsumerState<Report> {
  // late final ValueNotifier<List<Product>> selectedEvents;

  @override
  void initState() {
    super.initState();
    ref.read(productRepositoryProvider).queryProductsWithWeekDays();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.report),
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
          const SizedBox(height: 8.0),
          // Expanded(
          //   child: ValueListenableBuilder<List<Product>>(
          //     valueListenable: selectedEvents,
          //     builder: (context, value, _) {
          //       return ProductList(value);
          //     },
          //   ),
          // ),
          buildSettingButton(),
        ],
      ),
    );
  }

  AppButton buildSettingButton() {
    return AppButton(
      text: Strings.setting,
      onPress: () async {
        AddProductRoute().push(context);
      },
    );
  }
}
