import 'package:daily_dairy_diary/models/MoreProduct.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/calendar_event_provider.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  // Let's allow get all products.
  Future<List<Product?>> fetchProduct() async {
    final productList =
        ref.watch(productRepositoryProvider).queryProductItems();
    return productList;
  }

  Future<List<MoreProduct?>> fetchMoreProduct() async {
    final productList =
        ref.watch(productRepositoryProvider).queryMoreProductItems();
    return productList;
  }

  @override
  FutureOr<List<Product?>> build() async {
    return fetchProduct();
  }

  // Let's allow add products.
  Future<void> addProduct(List<Product> product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.createProduct(product);
      return fetchProduct();
    });
  }

  // Let's allow add more products.
  Future<void> addMoreProduct(MoreProduct product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.createMoreProduct(product);
      return fetchProduct();
    });
  }

  // Let's allow removing products.
  Future<void> removeProduct(Product productId) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.deleteProduct(productId);
      return fetchProduct();
    });
  }

  // Let's allow edit product.
  Future<void> editProduct(Product product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.updateProduct(product);
      return fetchProduct();
    });
  }
}
