import "package:flutter/material.dart";

/// The colour palette. These are raw colours with no light or dark meaning;
/// UI code reads the themed pairs from `AppColorsRef` (`ref.surface`,
/// `ref.textSecondary`, …) instead.
abstract final class AppColors {
  // Brand.
  static const Color prussianBlue = Color(0xFF000022);
  static const Color deepNavy = Color(0xFF001242);
  static const Color oceanBlue = Color(0xFF0094C6);
  static const Color balticBlue = Color(0xFF005E7C);
  static const Color inkBlack = Color(0xFF040F16);

  // Neutrals and status colours for the light theme.
  static const Color snow = Color(0xFFF6FAFE);
  static const Color mist = Color(0xFFDFE3E7);
  static const Color slate700 = Color(0xFF40484C);
  static const Color slate500 = Color(0xFF71787D);
  static const Color red = Color(0xFFBA1A1A);

  // Neutrals and status colours for the dark theme.
  static const Color frost = Color(0xFFE6EEF3);
  static const Color slate300 = Color(0xFF9DB0BC);
  static const Color slate600 = Color(0xFF5C6B78);
  static const Color sky = Color(0xFF6FC8EA);
  static const Color salmon = Color(0xFFFFB4AB);

  static const Color white = Color(0xFFFFFFFF);
}
