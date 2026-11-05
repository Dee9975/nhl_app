import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// Label on the left, bold value on the right. The value wraps when long.
class const StatRow({
  super.key,
  required final String label,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: spaceSM),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.paragraph2),
          const SizedBox(width: spaceXL),
          // Long values (e.g. a birthplace) wrap instead of overflowing.
          Expanded(
            child: Text(
              value,
              textAlign: .end,
              style: AppTextStyles.paragraph2Bold,
            ),
          ),
        ],
      ),
    );
  }
}
