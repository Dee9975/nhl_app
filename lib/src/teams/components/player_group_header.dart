import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";

/// Uppercase roster group title with its player count, e.g. `FORWARDS 16`.
class const PlayerGroupHeader({
  super.key,
  required final String title,
  required final int count,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const .fromLTRB(spaceXL, spaceXXL, spaceXL, spaceMD),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: .bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: spaceMD),
          Text(
            "$count",
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
