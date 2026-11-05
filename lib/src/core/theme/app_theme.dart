import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// Themes for Flutter's built-in widgets (navigation bar, segmented buttons,
/// switches, chips, progress indicators, dividers), built from the same
/// [AppColorPairs] as [AppColorsRef]. App code uses `ref.<colour>` and
/// [AppTextStyles] instead of reading the theme.
abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    // The seed fills the roles not set below, e.g. container colours.
    colorScheme: ColorScheme.fromSeed(seedColor: AppColorPairs.primary.light)
        .copyWith(
          primary: AppColorPairs.primary.light,
          onPrimary: AppColorPairs.onPrimary.light,
          secondary: AppColors.deepNavy,
          onSecondary: AppColors.white,
          tertiary: AppColorPairs.accent.light,
          onTertiary: AppColors.inkBlack,
          surface: AppColorPairs.surface.light,
          surfaceContainerHighest: AppColorPairs.surfaceVariant.light,
          onSurface: AppColorPairs.textPrimary.light,
          onSurfaceVariant: AppColorPairs.textSecondary.light,
          outline: AppColorPairs.outline.light,
          error: AppColorPairs.error.light,
          inverseSurface: AppColors.prussianBlue,
        ),
    textTheme: _textTheme,
  );

  static final ThemeData dark = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColorPairs.primary.dark,
          brightness: .dark,
        ).copyWith(
          primary: AppColorPairs.primary.dark,
          onPrimary: AppColorPairs.onPrimary.dark,
          secondary: AppColors.sky,
          onSecondary: AppColors.prussianBlue,
          tertiary: AppColorPairs.accent.dark,
          onTertiary: AppColors.prussianBlue,
          surface: AppColorPairs.surface.dark,
          surfaceContainerHighest: AppColorPairs.surfaceVariant.dark,
          onSurface: AppColorPairs.textPrimary.dark,
          onSurfaceVariant: AppColorPairs.textSecondary.dark,
          outline: AppColorPairs.outline.dark,
          error: AppColorPairs.error.dark,
          inverseSurface: AppColors.frost,
        ),
    textTheme: _textTheme,
  );

  // label* stay Flutter's defaults: buttons, chips and navigation labels
  // use them and keep their look.
  static const TextTheme _textTheme = TextTheme(
    headlineSmall: AppTextStyles.title1,
    titleLarge: AppTextStyles.title2,
    titleMedium: AppTextStyles.title3,
    titleSmall: AppTextStyles.paragraph2Bold,
    bodyLarge: AppTextStyles.paragraph1,
    bodyMedium: AppTextStyles.paragraph2,
    bodySmall: AppTextStyles.paragraph3,
  );
}
