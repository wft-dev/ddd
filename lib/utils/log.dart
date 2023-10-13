import 'package:flutter/foundation.dart';

/// Prints [o] in debug-mode only.
void printSafe(Object? o) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(o);
  }
}
