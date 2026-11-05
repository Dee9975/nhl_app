import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart";
import "package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart";

import "package:nhl_app/src/core/core.dart";

Future<SharedPreferencesWithCache> _preferences() {
  return SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
}

void main() {
  Future<ProviderContainer> containerWith(Map<String, Object> stored) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(stored);
    return ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(await _preferences()),
      ],
    );
  }

  test("starts light when nothing is saved", () async {
    final ProviderContainer container = await containerWith({});

    expect(container.read(darkThemeProvider), isFalse);
  });

  test("restores the saved choice", () async {
    final ProviderContainer container = await containerWith({
      DarkTheme.storageKey: true,
    });

    expect(container.read(darkThemeProvider), isTrue);
  });

  test("set switches at once and is there on the next launch", () async {
    final ProviderContainer container = await containerWith({});

    container.read(darkThemeProvider.notifier).set(true);

    expect(container.read(darkThemeProvider), isTrue);
    await pumpEventQueue();
    final SharedPreferencesWithCache nextLaunch = await _preferences();
    expect(nextLaunch.getBool(DarkTheme.storageKey), isTrue);
  });
}
