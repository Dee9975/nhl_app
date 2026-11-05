import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

/// Width of the rank column, so rows and dividers line up.
const double leaderRankWidth = 28;

/// One leaderboard entry: rank, headshot, name, team and the stat value.
class const LeaderRow({
  super.key,
  required final int rank,
  required final StatLeader leader,
  required final LeaderCategory category,
  final VoidCallback? onTap,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = "${leader.firstName.value} ${leader.lastName.value}";

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .symmetric(horizontal: spaceXL, vertical: spaceMD),
        child: Row(
          children: [
            SizedBox(
              width: leaderRankWidth,
              child: Text(
                "$rank",
                style: AppTextStyles.title3Bold.copyWith(
                  color: ref.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: spaceMD),
            PlayerHeadshot(url: leader.headshot, radius: 28),
            const SizedBox(width: spaceXL),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: AppTextStyles.title3Bold,
                  ),
                  Text(
                    "${leader.teamAbbrev} · ${leader.position} · "
                    "#${leader.sweaterNumber}",
                    style: AppTextStyles.paragraph3.copyWith(
                      color: ref.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: spaceMD),
            Text(
              category.format(leader.value),
              style: AppTextStyles.title2Bold,
            ),
          ],
        ),
      ),
    );
  }
}
