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

    return products.isEmpty
        ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p6.sw),
              child: Text(
                message ?? Strings.noData,
                style: CustomTextStyle.titleStyle().copyWith(
                  fontSize: Sizes.p4.sw,
                ),
              ),
            ),
          )
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final productItem = products[index]!;
              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: Sizes.p1.sh, horizontal: Sizes.p16.sw),
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
                    // AppButton(
                    //   // height: Sizes.p8.sh,
                    //   // width: Sizes.p4.sw,
                    //   // isIcon: true,
                    //   // icon: const Icon(Icons.delete),
                    //   onPress: () async {
                    //     ref
                    //         .read(productControllerProvider.notifier)
                    //         .removeProduct(productItem);
                    //   },
                    // ),

                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(left: Sizes.p1.sw),
                            padding: EdgeInsets.symmetric(
                                vertical: Sizes.p01.sh,
                                horizontal: Sizes.p2.sw),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: AppColors.alphaPurpleColor,
                              ),
                              borderRadius: BorderRadius.circular(Sizes.p2.sw),
                            ),
                            child: Text(
                              '${productItem.type}',
                              style:
                                  CustomTextStyle.buttonTitleStyle().copyWith(
                                color: AppColors.thinPurpleColor,
                                fontSize: Sizes.p2_5.sw,
                                fontWeight: Fonts.fontWeightSemiBold,
                              ),
                            ),
                          ),
                          Text(
                            '${productItem.name}',
                            style: CustomTextStyle.titleStyle().copyWith(
                                fontSize: Sizes.p5.sw,
                                fontWeight: Fonts.fontWeightMedium),
                          ),
                          Text(
                            'Q${productItem.quantity}',
                            style: CustomTextStyle.buttonTitleStyle().copyWith(
                              color: AppColors.thinPurpleColor,
                              fontSize: Sizes.p3.sw,
                              fontWeight: Fonts.fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              '\$${productItem.price}',
                              style:
                                  CustomTextStyle.buttonTitleStyle().copyWith(
                                color: AppColors.thinPurpleColor,
                                fontSize: Sizes.p3_5.sw,
                                fontWeight: Fonts.fontWeightMedium,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: Sizes.p6.sw,
                              height: Sizes.p3.sh,
                              child: VerticalDivider(
                                color: AppColors.dimPurpleColor,
                                thickness: Sizes.p03.sw,
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppPopMenu(
                              onSelected: (value, type) async {
                                if (type == Options.delete.name) {
                                  // ref
                                  //     .read(productControllerProvider.notifier)
                                  //     .removeProduct(productItem);
                                } else {
                                  // AddProductRoute($extra: productItem)
                                  //     .push(context);
                                }

                                print(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // children: buildMoreProductView(moreProductList),
              );
            },
          );
  }
//flutter make first list cap of string
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
