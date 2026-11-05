/// Shared number formats for hockey stats.
abstract final class StatFormat {
  /// Save percentage the hockey way: `0.923` as `.923`, `1.0` as `1.000`.
  static String savePct(double value) {
    final String fixed = value.toStringAsFixed(3);
    return fixed.startsWith("0.") ? fixed.substring(1) : fixed;
  }

  /// Fraction as a percentage with one decimal, e.g. `0.1516` as `15.2%`.
  static String percent(num fraction) {
    return "${(fraction * 100).toStringAsFixed(1)}%";
  }

  /// Seconds as `m:ss`, e.g. `1710` as `28:30`.
  static String minutes(int seconds) {
    final String secs = (seconds % 60).toString().padLeft(2, "0");
    return "${seconds ~/ 60}:$secs";
  }

  /// Adds a leading `+` to positive numbers, e.g. `+23`, `0`, `-4`.
  static String signed(int value) {
    return switch (value) {
      > 0 => "+$value",
      _ => "$value",
    };
  }

  /// `20262027` as `2026-27`; anything else as given.
  static String season(int season) {
    final String text = "$season";
    return switch (text.length) {
      8 => "${text.substring(0, 4)}-${text.substring(6)}",
      _ => text,
    };
  }

  /// Inches as feet and inches, e.g. `74` as `6'2"`.
  static String height(int inches) {
    return "${inches ~/ 12}'${inches % 12}\"";
  }

  /// `1st`, `2nd`, `3rd`, `4th` ... `11th`, `12th`, `13th`, `21st`.
  static String ordinal(int n) {
    final String suffix = switch ((n % 100, n % 10)) {
      (11 || 12 || 13, _) => "th",
      (_, 1) => "st",
      (_, 2) => "nd",
      (_, 3) => "rd",
      _ => "th",
    };
    return "$n$suffix";
  }
}
