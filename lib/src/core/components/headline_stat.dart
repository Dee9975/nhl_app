import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// Large value over a small label, e.g. `82` over `GP`. Fills an equal share
/// of a [Row].
class const HeadlineStat({
  super.key,
  required final String label,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.title1Bold),
          Text(label, style: AppTextStyles.paragraph3),
        ],
      ),
    );
  }
}
