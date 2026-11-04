import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.balticBlue).copyWith(
      primary: AppColors.balticBlue,
      onPrimary: Colors.white,
      secondary: AppColors.deepNavy,
      onSecondary: Colors.white,
      tertiary: AppColors.oceanBlue,
      onTertiary: AppColors.inkBlack,
      inverseSurface: AppColors.prussianBlue,
      onSurface: AppColors.inkBlack,
    ),
  );
}
