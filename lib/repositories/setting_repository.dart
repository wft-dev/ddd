import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/provider/setting_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_repository.g.dart';

class SettingRepository {
  Future<void> createSetting(Setting setting) async {
    try {
      final request = ModelMutations.create(setting);
      final response = await Amplify.API.mutate(request: request).response;

      final createSetting = response.data;
      if (createSetting == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createSetting.name}');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  Future<void> updateSetting(Setting setting) async {
    try {
      final request = ModelMutations.update(setting);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  Future<void> deleteSetting(Setting settingToDelete) async {
    try {
      final request = ModelMutations.delete(settingToDelete);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  Future<List<Setting?>> querySettingItems() async {
    try {
      final request = ModelQueries.list(Setting.classType);
      final response = await Amplify.API.query(request: request).response;

      final settings = response.data?.items;
      if (settings == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return settings;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
SettingRepository settingRepository(SettingRepositoryRef ref) {
  return SettingRepository();
}
