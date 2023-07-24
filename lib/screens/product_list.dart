import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/MoreProduct.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // productRepositoryProvider).queryProductItems()
    // ref.listen<AsyncValue>(
    //   productRepositoryProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    final productList = ref.watch(productControllerProvider);
    return productList.when(
        data: (product) => ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                final productItem = product[index]!;
                final moreProductList = productItem.moreProducts;
                print("productItem == $productItem");

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
                        height: Sizes.p8.sh,
                        width: Sizes.p4.sw,
                        isIcon: true,
                        icon: const Icon(Icons.delete),
                        onPress: () async {
                          ref
                              .read(productControllerProvider.notifier)
                              .removeTodo(productItem);
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
                            height: Sizes.p4.sh,
                            width: Sizes.p4.sw,
                            isIcon: true,
                            icon: const Icon(Icons.edit),
                            onPress: () async {
                              //  ref.read(productControllerProvider).removeTodo(productItem);
                            },
                          ),
                        ],
                      ),
                    ]),
                    children: buildMoreProductView(moreProductList),
                  ),
                );
              },
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (err, stack) => Text('Error: $err'));
  }

  List<Widget> buildMoreProductView(List<MoreProduct>? moreProductList) {
    return moreProductList == null
        ? [const Text('2')]
        : moreProductList
            .map((moreProductItem) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${moreProductItem.name}'),
                      Text('${moreProductItem.price}'),
                      Text('${moreProductItem.quantity}')
                    ]))
            .toList();
  }
}
