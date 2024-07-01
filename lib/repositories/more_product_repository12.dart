import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/Product.dart';

class ProductRepository {
  Future<void> createProduct(Product product) async {
    try {
      // final request = ModelMutations.create(product);
      // final response = await Amplify.API.mutate(request: request).response;
      // final v = product.moreProducts;
      // if (v != null) {
      //   final request2 = ModelMutations.create(v[0]);
      //   final response2 = await Amplify.API.mutate(request: request2).response;
      //   final createdProduct2 = response2.data;
      //   safePrint('Mutation result: $createdProduct2');
      // }

      // final getTodoRequest = GraphQLRequest<Todo>(
      //   document: graphQLDocument,
      //   modelType: Todo.classType,
      //   variables: <String, String>{'id': someTodoId},
      //   decodePath: getTodo,
      // );

      // var operation = Amplify.API.mutate<String>(
      //   request: GraphQLRequest(
      //     document: Queries.createProduct,
      //     variables: {
      //       "name": 'milk',
      //     },
      //   ),
      // );
      // var response = await operation.response;
      // safePrint('errors: $response');
      // var data = json.decode(response.data as String);

      // final createdProduct = response.data;
      // if (createdProduct == null) {
      //   safePrint('errors: ${response.errors}');
      //   return;
      // }
      // safePrint('Mutation result: ${createdProduct.name}');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  Future<void> updateProduct(Product originalProduct) async {
    final productWithNewName = originalProduct.copyWith(price: 10);

    final request = ModelMutations.update(productWithNewName);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  Future<void> deleteProduct(Product productToDelete) async {
    final request = ModelMutations.delete(productToDelete);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Response: $response');
  }

  Future<List<Product?>> queryProductItems() async {
    try {
      final request = ModelQueries.list(Product.classType);
      final response = await Amplify.API.query(request: request).response;

      final products = response.data?.items;
      if (products == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return products;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }
}
