// ignore_for_file: strict_raw_type

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Useful to log state change in our application
/// Read the logs and you'll better understand what's going on under the hood

class StateLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
//     print('''
// {
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''');
  }
}
