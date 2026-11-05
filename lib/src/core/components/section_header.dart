import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Uppercase section title, optionally with an item count, e.g.
/// `FORWARDS 16`.
class const SectionHeader({
  super.key,
  required final String title,
  final int? count,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const .fromLTRB(spaceXL, spaceXXL, spaceXL, spaceMD),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: .ellipsis,
              style: AppTextStyles.paragraph2Bold.copyWith(letterSpacing: 1.2),
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: spaceMD),
            Text(
              "$count",
              style: AppTextStyles.paragraph2Bold.copyWith(
                color: ref.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
