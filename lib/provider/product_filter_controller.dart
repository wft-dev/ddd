import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/models/filter_date.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_filter_controller.g.dart';

@riverpod
class ProductFilterController extends _$ProductFilterController {
  @override
  FutureOr<List<Product?>> build() async {
    return getAllProducts();
  }

  // Let's allow get all products.
  Future<List<Product?>> getAllProducts() async {
    final productList =
        ref.watch(productControllerProvider.notifier).fetchProduct();
    return productList;
  }

  // Let's filter products based on week, month, year and date range.
  Future<void> filterProductWithDate(FilterDate date) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async =>
        await productRepository.queryProductsWithDateFiltration(date));
  }
}
