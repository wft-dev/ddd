import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/router/routes.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductList extends ConsumerWidget {
  const ProductList(this.products, {this.message, super.key});
  final List<Product?> products;
  final String? message;

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
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  leading: const Icon(Icons.all_inclusive),
                  title: Column(children: [
                    AppButton(
                      // height: Sizes.p8.sh,
                      // width: Sizes.p4.sw,
                      // isIcon: true,
                      // icon: const Icon(Icons.delete),
                      onPress: () async {
                        ref
                            .read(productControllerProvider.notifier)
                            .removeProduct(productItem);
                      },
                    ),
                    Text('${productItem.type}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${productItem.name}'),
                        Text('${productItem.price}'),
                        Text('${productItem.quantity}'),
                        AppButton(
                          // height: Sizes.p4.sh,
                          // width: Sizes.p4.sw,
                          // isIcon: true,
                          // icon: const Icon(Icons.edit),
                          onPress: () async {
                            AddProductRoute($extra: productItem).push(context);
                          },
                        ),
                      ],
                    ),
                  ]),
                  // children: buildMoreProductView(moreProductList),
                ),
              );
            },
          );
  }

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
