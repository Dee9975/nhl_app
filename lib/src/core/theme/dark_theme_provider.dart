import "dart:async";
import "dart:developer";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "dark_theme_provider.g.dart";

/// Whether the dark theme is on. Starts light; the choice is saved and
/// restored on the next launch.
@Riverpod(keepAlive: true)
class DarkTheme extends _$DarkTheme {
  /// Preferences key the choice is saved under.
  static const String storageKey = "dark_theme";

  @override
  bool build() =>
      ref.watch(sharedPreferencesProvider).getBool(storageKey) ?? false;

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
