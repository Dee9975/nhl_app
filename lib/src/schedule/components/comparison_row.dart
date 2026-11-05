import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Away value on the left, label in the middle, home value on the right.
class const ComparisonRow({
  super.key,
  required final String label,
  required final String away,
  required final String home,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const TextStyle valueStyle = AppTextStyles.paragraph2Bold;

    return Padding(
      padding: const .symmetric(vertical: spaceSM),
      child: Row(
        children: [
          Expanded(child: Text(away, style: valueStyle)),
          Text(
            label,
            style: AppTextStyles.paragraph3.copyWith(color: ref.textSecondary),
          ),
          Expanded(
            child: Text(home, textAlign: .end, style: valueStyle),
          ),
        ],
      ),
    );
  }
}
