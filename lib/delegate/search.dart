import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/screens/product_list.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.productList})
      : super(
          searchFieldStyle: TextStyle(color: blackColor, fontSize: Sizes.p4.sw),
        );
  late final List<Product?> productList;

  @override
  String get searchFieldLabel => Strings.searchPlaceHolder;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(400, 16.0),
          ),
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.titleLarge!
            .copyWith(color: grayColor, fontSize: Sizes.p3_3.sw),
        fillColor: whiteColor,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: bgColor, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: bgColor, width: 0),
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
    return Container();
  }

// Show the products based on the search query like name, type, price, quantity.
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (var item in productList) {
      if (item!.name!.toLowerCase().contains(query.toLowerCase()) ||
          item.type!.toLowerCase().contains(query.toLowerCase()) ||
          item.price!.toString().contains(query) ||
          item.quantity!.toString().contains(query)) {
        matchQuery.add(item);
      }
    }
    return matchQuery.isEmpty
        ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p6.sw),
              child: Text(
                Strings.noSearchResultMessage(query),
                style: CustomTextStyle.titleStyle()
                    .copyWith(fontSize: Sizes.p4.sw),
              ),
            ),
          )
        : ProductList(matchQuery);
  }
}
