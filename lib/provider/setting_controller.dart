import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/repositories/setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_controller.g.dart';

@riverpod
class SettingController extends _$SettingController {
  Future<List<Setting?>> fetchSetting() async {
    final settingList =
        ref.watch(settingRepositoryProvider).querySettingItems();
    return settingList;
  }

  @override
  FutureOr<List<Setting?>> build() async {
    return fetchSetting();
  }

  // Let's allow add setting.
  Future<void> addSetting(Setting setting) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await settingRepository.createSetting(setting);
      return fetchSetting();
    });
  }

  // Let's allow removing setting.
  Future<void> removeSetting(Setting settingId) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await settingRepository.deleteSetting(settingId);
      return fetchSetting();
    });
  }

  // Let's allow edit setting.
  Future<void> editSetting(Setting setting) async {
    final settingRepository = ref.watch(settingRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await settingRepository.updateSetting(setting);
      return fetchSetting();
    });
  }
}
