import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/api_service/queries.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

class ProductRepository {
  // This [GraphQL] mutation is used for create [Product].
  Future<void> createProduct(List<Product> products) async {
    try {
      for (var productData in products) {
        final request = ModelMutations.create(productData);
        final response = await Amplify.API.mutate(request: request).response;
        final createdProduct = response.data;
        if (createdProduct == null) {
          safePrint('errors: ${response.errors}');
          throw response.errors;
        }
        safePrint('Mutation result: ${createdProduct.name}');
      }
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for create [MoreProduct].
  Future<void> createMoreProduct(MoreProduct product) async {
    try {
      final request = ModelMutations.create(product);
      final response = await Amplify.API.mutate(request: request).response;
      final createdProduct = response.data;
      if (createdProduct == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      safePrint('Mutation result: $createdProduct');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  Future<void> createProductList(List<Product> product) async {
    try {
      final todoList = product;
      final List<Map<String, dynamic>> todoListInput =
          todoList.map((todo) => todo.toJson()).toList();

      var result = Amplify.API.mutate<String>(
        request: GraphQLRequest(
          document: Queries.product,
          variables: {
            "input": todoListInput,
          },
        ),
      );
      // final result = Amplify.API.mutate(
      //   request: Queries.product,
      //     variables: {'input': todoListInput},
      //   );
      var response = await result.response;
      print(response);
      // var response =  result.data;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for update the [Product].
  Future<void> updateProduct(Product originalProduct) async {
    try {
      final request = ModelMutations.update(originalProduct);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for delete the [Product].
  Future<void> deleteProduct(Product productToDelete) async {
    try {
      final request = ModelMutations.delete(productToDelete);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] query is used for get the list of [Product].
  Future<List<Product?>> queryProductItems() async {
    try {
      final request = ModelQueries.list(Product.classType);
      final response = await Amplify.API.query(request: request).response;
      final products = response.data?.items;
      if (products == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      return products;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] query is used for get the list of [MoreProduct].
  Future<List<MoreProduct?>> queryMoreProductItems() async {
    try {
      final request = ModelQueries.list(MoreProduct.classType);
      final response = await Amplify.API.query(request: request).response;
      final products = response.data?.items;
      if (products == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      return products;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }
}

//[ProductRepository] provider.
@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository();
}
