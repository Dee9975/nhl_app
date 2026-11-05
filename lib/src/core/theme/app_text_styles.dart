import "package:flutter/material.dart";

/// Every text style the app uses, as constants. `1` is the biggest, `3` the
/// smallest; each has a bold variant.
///
/// No colour is set, so text uses the default text colour unless a
/// `copyWith(color: AppColors.…)` adds one.
abstract final class AppTextStyles {
  static const TextStyle title1 = TextStyle(fontSize: 24, fontWeight: .w500);
  static const TextStyle title2 = TextStyle(fontSize: 20, fontWeight: .w500);
  static const TextStyle title3 = TextStyle(fontSize: 16, fontWeight: .w500);

  static const TextStyle title1Bold = TextStyle(
    fontSize: 24,
    fontWeight: .w700,
  );
  static const TextStyle title2Bold = TextStyle(
    fontSize: 20,
    fontWeight: .w700,
  );
  static const TextStyle title3Bold = TextStyle(
    fontSize: 16,
    fontWeight: .w700,
  );

  static const TextStyle paragraph1 = TextStyle(
    fontSize: 16,
    fontWeight: .w400,
  );
  static const TextStyle paragraph2 = TextStyle(
    fontSize: 14,
    fontWeight: .w400,
  );
  static const TextStyle paragraph3 = TextStyle(
    fontSize: 12,
    fontWeight: .w400,
  );

  static const TextStyle paragraph1Bold = TextStyle(
    fontSize: 16,
    fontWeight: .w700,
  );
  static const TextStyle paragraph2Bold = TextStyle(
    fontSize: 14,
    fontWeight: .w700,
  );
  static const TextStyle paragraph3Bold = TextStyle(
    fontSize: 12,
    fontWeight: .w700,
  );
}
