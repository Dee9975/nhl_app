import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Turns the dark theme on or off; the choice is saved.
class const DarkThemeSwitch({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: const Text("Dark theme", style: AppTextStyles.paragraph1),
      value: ref.watch(darkThemeProvider),
      onChanged: ref.read(darkThemeProvider.notifier).set,
    );
  }
}
