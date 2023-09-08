import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Inventory.dart';
import 'package:daily_dairy_diary/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inventory_repository.g.dart';

class InventoryRepository {
  // This [GraphQL] mutation is used for create [Inventory].
  Future<Result> createInventory(List<Inventory> inventories) async {
    try {
      for (var inventoryData in inventories) {
        final request = ModelMutations.create(inventoryData);
        final response = await Amplify.API.mutate(request: request).response;
        final createInventory = response.data;
        if (createInventory == null) {
          throw response.errors;
        }
      }
      return const Result(actionType: ActionType.add);
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] query is used for get the list of [Inventory].
  Future<List<Inventory?>> queryInventoryItems() async {
    try {
      final request = ModelQueries.list(Inventory.classType);
      final response = await Amplify.API.query(request: request).response;
      final inventories = response.data?.items;
      if (inventories == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      return inventories;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for delete the [Inventory].
  Future<Result> deleteInventory(Inventory inventoryToDelete) async {
    try {
      final request = ModelMutations.deleteById(
        Inventory.classType,
        InventoryModelIdentifier(id: inventoryToDelete.id),
      );
      final response = await Amplify.API.mutate(request: request).response;
      return Result(
          actionType:
              response.data != null ? ActionType.delete : ActionType.none);
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }
}

//[InventoryRepository] provider.
@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(InventoryRepositoryRef ref) {
  return InventoryRepository();
}
