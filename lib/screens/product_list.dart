import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ProductList extends ConsumerWidget {
  const ProductList(this.products,
      {this.message, this.selectedMenu, super.key});
  final List<Product?> products;
  final String? message;
  final SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // productRepositoryProvider).queryProductItems()
    // ref.listen<AsyncValue>(
    //   productRepositoryProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    // final productList = ref.watch(productControllerProvider);
    // print(productList);
    return products.isEmpty ? buildMessage() : buildList(ref);
  }

  // If there is no data found, then show message.
  Widget buildMessage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p6.sw),
        child: Text(
          message ?? Strings.noData,
          style: CustomTextStyle.titleStyle().copyWith(
            fontSize: Sizes.p4.sw,
          ),
        ),
      ),
    );
  }

  // Show product list.
  ListView buildList(WidgetRef ref) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productItem = products[index]!;
        return buildListItems(productItem, context, ref);
      },
    );
  }

  // Show product list items.
  Widget buildListItems(
      Product productItem, BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
          top: Sizes.p2.sh,
          bottom: Sizes.p2.sh,
          left: Sizes.p16.sw,
          right: Sizes.p10.sw),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.alphaPurpleColor,
            width: Sizes.p02.sw,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNameType(productItem),
          buildPriceAndEditDeleteMenu(productItem, context, ref),
        ],
      ),
      // children: buildMoreProductView(moreProductList),
    );
  }

  // This [Widget] is used show name, type, quantity.
  Widget buildNameType(Product productItem) {
    return Flexible(
      flex: Sizes.pInt1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin: EdgeInsets.only(left: Sizes.p1.sw),
            padding: EdgeInsets.symmetric(
                vertical: Sizes.p01.sh, horizontal: Sizes.p2.sw),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.rectangle,
              border: Border.all(
                color: AppColors.alphaPurpleColor,
              ),
              borderRadius: BorderRadius.circular(Sizes.p2.sw),
            ),
            child: buildText('${productItem.type}', AppColors.thinPurpleColor,
                Sizes.p2_5.sw, Fonts.fontWeightSemiBold),
          ),
          buildText('${productItem.name}', AppColors.darkPurpleColor,
              Sizes.p5.sw, Fonts.fontWeightMedium),
          buildText('Q${productItem.quantity}', AppColors.thinPurpleColor,
              Sizes.p3.sw, Fonts.fontWeightMedium),
        ],
      ),
    );
  }

  // This [Widget] is used show price and menu for edit and delete the product.
  Widget buildPriceAndEditDeleteMenu(
      Product productItem, BuildContext context, WidgetRef ref) {
    return Flexible(
      flex: Sizes.pInt1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: Sizes.pInt3,
            child: buildText(
                '\$${productItem.price ?? ''}',
                AppColors.thinPurpleColor,
                Sizes.p3_5.sw,
                Fonts.fontWeightMedium),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.p2.sw,
            ),
            child: SizedBox(
              width: Sizes.p1.sw,
              height: Sizes.p3.sh,
              child: VerticalDivider(
                color: AppColors.dimPurpleColor,
                thickness: Sizes.p01.sw,
              ),
            ),
          ),
          Expanded(
            child: AppPopMenu(
              onSelected: (value, type) async {
                if (type == Options.delete.name) {
                  await ref
                      .read(productControllerProvider.notifier)
                      .removeProduct(productItem);
                } else if (type == Options.edit.name) {
                  AddProductRoute($extra: productItem).push(context);
                }

                print(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  // [Text]
  Text buildText(
      String title, Color? color, double? fontSize, FontWeight? fontWeight) {
    return Text(
      title,
      style: CustomTextStyle.titleStyle().copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
//
  // List<Widget> buildMoreProductView(List<MoreProduct>? moreProductList) {
  //   return moreProductList == null
  //       ? []
  //       : moreProductList
  //           .map((moreProductItem) => Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Text('${moreProductItem.name}'),
  //                     Text('${moreProductItem.price}'),
  //                     Text('${moreProductItem.quantity}')
  //                   ]))
  //           .toList();
  // }
}
