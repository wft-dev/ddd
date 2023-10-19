import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate()
      : super(
          searchFieldStyle: TextStyle(
              color: AppColors.darkPurpleColor, fontSize: Sizes.p4.sw),
        );

  @override
  String get searchFieldLabel => Strings.searchPlaceHolder;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.darkPurpleColor),
        elevation: Sizes.p0,
        backgroundColor: AppColors.lightPurpleColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.titleLarge!
            .copyWith(color: AppColors.grayColor, fontSize: Sizes.p3_3.sw),
        fillColor: AppColors.whiteColor,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
            vertical: Sizes.p4, horizontal: Sizes.p8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.bgColor, width: Sizes.p0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.bgColor, width: Sizes.p0),
        ),
      ),
      // textTheme: theme.textTheme.copyWith(
      //   titleMedium: theme.textTheme.titleMedium!
      //       .copyWith(color: grayColor, fontSize: Sizes.p1.sw),
      // ),
    );
  }

// Clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// Pop out of search menu.
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

// Show query result
  @override
  Widget buildResults(BuildContext context) {
    return buildSearchList();
  }

// Show the products based on the search query like name, type, price, quantity.
  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchList();
  }

  // Show search list
  buildSearchList() {
    return Consumer(
      builder: (context, ref, child) {
        List<Product> matchQuery = [];

        final products = ref.watch(productControllerProvider).value;
        if (products != null) {
          final List? productItems = products.items;
          if (productItems != null && productItems.isNotEmpty) {
            for (var item in productItems) {
              if (item!.name!.toLowerCase().contains(query.toLowerCase()) ||
                  item.type!.toLowerCase().contains(query.toLowerCase()) ||
                  item.price!.toString().contains(query) ||
                  item.quantity!.toString().contains(query)) {
                matchQuery.add(item);
              }
            }
          } else {
            matchQuery.clear();
          }
        }
        return Container(
          height: ResponsiveAppUtil.height,
          color: AppColors.alphaPurpleColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(Sizes.p12.sw)),
            ),
            padding: EdgeInsets.symmetric(vertical: Sizes.p2.sh),
            child: ProductList(
              matchQuery,
              message: matchQuery.isEmpty
                  ? null
                  : Strings.noSearchResultMessage(query),
            ),
          ),
        );
      },
    );
  }
}
