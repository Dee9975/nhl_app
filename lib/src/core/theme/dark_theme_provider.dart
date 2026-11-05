import "dart:async";
import "dart:developer";
import "dart:ui";

import "package:shared_preferences/shared_preferences.dart";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "dark_theme_provider.g.dart";

/// Whether the dark theme is on. The first launch saves the device's
/// setting (see [saveDeviceDefault]); after that the saved choice is
/// restored.
@Riverpod(keepAlive: true)
class DarkTheme extends _$DarkTheme {
  /// Preferences key the choice is saved under.
  static const String storageKey = "dark_theme";

  @override
  bool build() =>
      ref.watch(sharedPreferencesProvider).getBool(storageKey) ?? false;

  /// Saves [device] as the choice when none is saved yet, so the first
  /// launch follows the device. Runs in `main.dart` before the first frame.
  /// A failed write is logged; the cache still holds the value, so this
  /// session uses it and the next launch tries again.
  static Future<void> saveDeviceDefault(
    SharedPreferencesWithCache preferences,
    Brightness device,
  ) async {
    if (preferences.containsKey(storageKey)) return;

    final Result<void> result = await Result.guard(
      preferences.setBool(storageKey, device == .dark),
    );
    switch (result) {
      case Ok():
        break;
      case Err(:final failure):
        log("Saving the device theme failed", error: failure);
    }
  }

  /// Switches the theme at once and saves the choice in the background.
  void set(bool dark) {
    state = dark;
    unawaited(_save(dark));
  }

  /// A failed write keeps the theme for this session and is logged; the
  /// app then starts with the previous choice next time.
  Future<void> _save(bool dark) async {
    final Result<void> result = await Result.guard(
      ref.read(sharedPreferencesProvider).setBool(storageKey, dark),
    );
    switch (result) {
      case Ok():
        break;
      case Err(:final failure):
        log("Saving the theme failed", error: failure);
    }
  }
}
