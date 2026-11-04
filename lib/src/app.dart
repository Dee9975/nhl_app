import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

class const App({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: "NHL",
    theme: AppTheme.light,
    routerConfig: ref.watch(routerProvider),
  );
}
