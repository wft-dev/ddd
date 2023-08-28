import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/models/result.dart';
import 'package:daily_dairy_diary/repositories/setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_controller.g.dart';

@riverpod
class SettingController extends _$SettingController {
  Future<Result> fetchSetting({actionType = ActionType.none}) async {
    final settingList =
        await ref.watch(settingRepositoryProvider).querySettingItems();
    return Result(items: settingList, actionType: actionType);
  }

  @override
  FutureOr<Result> build() async {
    return fetchSetting();
  }

  // Let's allow add setting.
  Future<void> fetchData() async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await settingRepository.querySettingItems();
      return fetchSetting();
    });
  }

  // Let's allow add setting.
  Future<void> addSetting(Setting setting) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await settingRepository.createSetting(setting);
      return fetchSetting(actionType: result.actionType);
    });
  }

  // Let's allow removing setting.
  Future<void> removeSetting(Setting settingId) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await settingRepository.deleteSetting(settingId);
      return fetchSetting(actionType: result.actionType);
    });
  }

  // Let's allow edit setting.
  Future<void> editSetting(Setting setting) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await settingRepository.updateSetting(setting);
      return fetchSetting(actionType: result.actionType);
    });
  }
}
