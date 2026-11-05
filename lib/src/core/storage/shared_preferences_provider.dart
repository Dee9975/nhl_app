import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part "shared_preferences_provider.g.dart";

/// Key-value storage, created once in `main` before the app starts and
/// injected with `overrideWithValue`.
@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferences(Ref ref) =>
    throw UnimplementedError("Overridden in main with overrideWithValue");
