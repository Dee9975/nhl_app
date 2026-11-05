import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "package:nhl_app/src/app.dart";
import "package:nhl_app/src/core/core.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferencesWithCache preferences =
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: {DarkTheme.storageKey},
        ),
      );
  await DarkTheme.saveDeviceDefault(
    preferences,
    PlatformDispatcher.instance.platformBrightness,
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      retry: (retryCount, error) => switch (error) {
        Offline() || TimeoutFailure() when retryCount < 3 => Duration(
          seconds: 1 << retryCount,
        ),
        _ => null,
      },
      child: const App(),
    ),
  );
}
