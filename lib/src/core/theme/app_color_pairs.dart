import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// A colour for each theme.
typedef ColorPair = ({Color light, Color dark});

/// Every themed colour role, defined once. [AppColorsRef] reads these for
/// widgets and [AppTheme] for Flutter's built-in widgets, so the two always
/// agree.
abstract final class AppColorPairs {
  /// Page and header background.
  static const ColorPair surface = (
    light: AppColors.snow,
    dark: AppColors.prussianBlue,
  );

  /// Fill behind avatars and placeholders.
  static const ColorPair surfaceVariant = (
    light: AppColors.mist,
    dark: AppColors.deepNavy,
  );

  /// Main text.
  static const ColorPair textPrimary = (
    light: AppColors.inkBlack,
    dark: AppColors.frost,
  );

  /// Captions, labels and placeholder icons.
  static const ColorPair textSecondary = (
    light: AppColors.slate700,
    dark: AppColors.slate300,
  );

  /// Highlights that aren't text, e.g. stat bars and win dots.
  static const ColorPair primary = (
    light: AppColors.balticBlue,
    dark: AppColors.oceanBlue,
  );

  /// Second highlight, e.g. the home team's stat bars.
  static const ColorPair accent = (
    light: AppColors.oceanBlue,
    dark: AppColors.sky,
  );

  /// Borders, e.g. around form dots.
  static const ColorPair outline = (
    light: AppColors.slate500,
    dark: AppColors.slate600,
  );

  /// Errors and the live game label.
  static const ColorPair error = (light: AppColors.red, dark: AppColors.salmon);

  /// Text and icons on [primary].
  static const ColorPair onPrimary = (
    light: AppColors.white,
    dark: AppColors.white,
  );
}
