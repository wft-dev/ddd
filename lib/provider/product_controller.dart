import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  Future<List<Product?>> fetchProduct() async {
    final productList =
        ref.watch(productRepositoryProvider).queryProductItems();
    return productList;
  }

  @override
  FutureOr<List<Product?>> build() async {
    return fetchProduct();
  }

  Future<void> addTodo(Product product) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.createProduct(product);
      return fetchProduct();
    });
  }

  // Let's allow removing products
  Future<void> removeTodo(Product productId) async {
    final productRepository = ref.watch(productRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await productRepository.deleteProduct(productId);
      return fetchProduct();
    });
  }

//   // Let's mark a product as completed
//   Future<void> toggle(String productId) async {
//         final productRepository = ref.watch(productRepositoryProvider);

//     state = const AsyncValue.loading();
//  state = await AsyncValue.guard(() async {
//       await productRepository.createProduct(product);
//       return fetchProduct();
//     })  }
}
