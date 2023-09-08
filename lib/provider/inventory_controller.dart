import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Inventory.dart';
import 'package:daily_dairy_diary/models/result.dart';
import 'package:daily_dairy_diary/repositories/inventory_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inventory_controller.g.dart';

@riverpod
class InventoryController extends _$InventoryController {
  // Let's allow get all inventories.
  Future<Result> fetchInventory({actionType = ActionType.none}) async {
    final inventoryList = await fetchInventoryList();
    return Result(items: inventoryList, actionType: actionType);
  }

  Future<List<Inventory?>> fetchInventoryList() async {
    final inventoryList =
        await ref.watch(inventoryRepositoryProvider).queryInventoryItems();
    return inventoryList;
  }

  @override
  FutureOr<Result> build() async {
    return fetchInventory();
  }

  // Let's allow add inventories.
  Future<void> addInventory(List<Inventory> inventory) async {
    final inventoryRepository = ref.watch(inventoryRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await inventoryRepository.createInventory(inventory);
      return fetchInventory(actionType: result.actionType);
    });
  }

  // Let's allow removing inventories.
  Future<void> removeInventory(Inventory inventoryId) async {
    final inventoryRepository = ref.watch(inventoryRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await inventoryRepository.deleteInventory(inventoryId);
      return fetchInventory(actionType: result.actionType);
    });
  }
}
