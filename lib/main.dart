import "dart:developer";
import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/app.dart";
import "package:nhl_app/src/core/core.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // TODO: forward to crash reporting.
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    log("Uncaught error", error: error, stackTrace: stackTrace);
    return true;
  };

  runApp(
    ProviderScope(
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
