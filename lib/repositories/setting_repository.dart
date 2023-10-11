import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/models/result.dart';

part 'setting_repository.g.dart';

class SettingRepository {
  // This [GraphQL] mutation is used for create [Setting].
  Future<Result> createSetting(Setting setting) async {
    try {
      final request = ModelMutations.create(setting);
      final response = await Amplify.API.mutate(request: request).response;
      final createSetting = response.data;
      if (createSetting == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      safePrint('Mutation result: ${createSetting.name}');
      return Result(
          actionType: response.data != null ? ActionType.add : ActionType.none);
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for update the [Setting].
  Future<Result> updateSetting(Setting setting) async {
    try {
      final request = ModelMutations.update(setting);
      final response = await Amplify.API.mutate(request: request).response;
      final updatedSetting = response.data;
      if (updatedSetting == null) {
        throw response.errors;
      }
      return const Result(actionType: ActionType.update);
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] mutation is used for delete the [Setting].
  Future<Result> deleteSetting(Setting settingToDelete) async {
    try {
      final request = ModelMutations.delete(settingToDelete);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
      return Result(
          actionType:
              response.data != null ? ActionType.delete : ActionType.none);
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }

  // This [GraphQL] query is used for get the list of [Setting].
  Future<List<Setting?>> querySettingItems() async {
    try {
      final request = ModelQueries.list(Setting.classType);
      final response = await Amplify.API.query(request: request).response;
      final settings = response.data?.items;
      if (settings == null) {
        safePrint('errors: ${response.errors}');
        throw response.errors;
      }
      return settings;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      rethrow;
    }
  }
}

//[SettingRepository] provider.
@Riverpod(keepAlive: true)
SettingRepository settingRepository(SettingRepositoryRef ref) {
  return SettingRepository();
}
