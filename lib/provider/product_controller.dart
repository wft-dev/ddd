import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/MoreProduct.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/models/result.dart';
import 'package:daily_dairy_diary/provider/calendar_event_provider.dart';
import 'package:daily_dairy_diary/provider/filter_date_controller.dart';
import 'package:daily_dairy_diary/provider/product_filter_controller.dart';
import 'package:daily_dairy_diary/provider/providers.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:daily_dairy_diary/screens/report.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  // Let's allow get all products.
  Future<Result> fetchProduct({actionType = ActionType.none}) async {
    final productList = await fetchProductList();
    return Result(items: productList, actionType: actionType);
  }

  Future<List<Product?>> fetchProductList() async {
    final productList =
        await ref.watch(productRepositoryProvider).queryProductItems();
    return productList;
  }

  @override
  FutureOr<Result> build() async {
    return fetchProduct();
  }

  // Let's allow add products.
  Future<void> addProduct(List<Product> product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await productRepository.createProduct(product);
      return fetchProduct(actionType: result.actionType);
    });
  }

  // // Let's allow add more products.
  // Future<void> addMoreProduct(MoreProduct product) async {
  //   final productRepository = ref.watch(productRepositoryProvider);
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() async {
  //     await productRepository.createMoreProduct(product);
  //     return fetchProduct();
  //   });
  // }

  // Let's allow removing products.
  Future<void> removeProduct(Product productId) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await productRepository.deleteProduct(productId);
      reportDataUpdate();
      return fetchProduct(actionType: result.actionType);
    });
  }

  // Let's allow edit product.
  Future<void> editProduct(Product product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await productRepository.updateProduct(product);
      reportDataUpdate();
      return fetchProduct(actionType: result.actionType);
    });
  }

  void reportDataUpdate() async {
    final filterDate = ref.watch(filterDateControllerProvider);
    await ref
        .read(productFilterControllerProvider.notifier)
        .filterProductWithDate(filterDate);
  }
}
