import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Themed colours. Each getter picks its side of an [AppColorPairs] pair;
/// reading one watches [darkThemeProvider], so the widget rebuilds when the
/// theme changes.
extension AppColorsRef on WidgetRef {
  /// [dark] while the dark theme is on, otherwise [light].
  Color color({required Color dark, required Color light}) {
    return watch(darkThemeProvider) ? dark : light;
  }

  /// The current theme's side of [pair].
  Color pair(ColorPair pair) => color(dark: pair.dark, light: pair.light);

  /// Page and header background.
  Color get surface => pair(AppColorPairs.surface);

  /// Fill behind avatars and placeholders.
  Color get surfaceVariant => pair(AppColorPairs.surfaceVariant);

  /// Main text.
  Color get textPrimary => pair(AppColorPairs.textPrimary);

  /// Captions, labels and placeholder icons.
  Color get textSecondary => pair(AppColorPairs.textSecondary);

  /// Highlights that aren't text, e.g. stat bars and win dots.
  Color get primary => pair(AppColorPairs.primary);

  /// Second highlight, e.g. the home team's stat bars.
  Color get accent => pair(AppColorPairs.accent);

  /// Borders, e.g. around form dots.
  Color get outline => pair(AppColorPairs.outline);

  /// Errors and the live game label.
  Color get error => pair(AppColorPairs.error);

  /// Text and icons on [primary].
  Color get onPrimary => pair(AppColorPairs.onPrimary);
}
