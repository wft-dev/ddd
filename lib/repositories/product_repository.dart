import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/Product.dart';

part 'product_repository.g.dart';

class ProductRepository {
  Future<void> createProduct(Product product) async {
    try {
      // final product = Product(name: 'milk', price: '20', quantity: '2');
      final request = ModelMutations.create(product);
      final response = await Amplify.API.mutate(request: request).response;

      final createdProduct = response.data;
      if (createdProduct == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdProduct.name}');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  Future<void> updateProduct(Product originalProduct) async {
    final productWithNewName = originalProduct.copyWith(price: '10');

    final request = ModelMutations.update(productWithNewName);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  Future<void> deleteProduct(Product productToDelete) async {
    final request = ModelMutations.delete(productToDelete);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository();
}
