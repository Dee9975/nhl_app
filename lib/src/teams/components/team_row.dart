import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Width of the rank column.
const double standingsRankWidth = 28;

/// Width of each GP, W, L and OTL column.
const double standingsStatWidth = 32;

/// Width of the PTS column.
const double standingsPointsWidth = 40;

/// One standings row: rank, logo, abbreviation, then GP, W, L, OTL and PTS
/// columns lined up with [StandingsColumnHeader].
class const TeamRow({
  super.key,
  required final int rank,
  required final TeamStanding standing,
  final VoidCallback? onTap,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .symmetric(horizontal: spaceXL, vertical: spaceMD),
        child: Row(
          children: [
            SizedBox(
              width: standingsRankWidth,
              child: Text(
                "$rank",
                style: AppTextStyles.paragraph2Bold.copyWith(
                  color: ref.textSecondary,
                ),
              ),
            ),
            TeamLogo(url: standing.teamLogo, size: 32),
            const SizedBox(width: spaceLG),
            Expanded(
              child: Text(
                standing.teamAbbrev.value,
                style: AppTextStyles.paragraph2Bold,
              ),
            ),
            for (final int value in [
              standing.gamesPlayed,
              standing.wins,
              standing.losses,
              standing.otLosses,
            ])
              SizedBox(
                width: standingsStatWidth,
                child: Text(
                  "$value",
                  textAlign: .center,
                  style: AppTextStyles.paragraph2,
                ),
              ),
            SizedBox(
              width: standingsPointsWidth,
              child: Text(
                "${standing.points}",
                textAlign: .end,
                style: AppTextStyles.paragraph2Bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
