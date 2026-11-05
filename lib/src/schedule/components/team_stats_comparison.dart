import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// This game's team stats, away on the left and home on the right, with
/// mirrored bars showing each team's share.
class const TeamStatsComparison({
  super.key,
  required final IList<TeamGameStat> stats,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: "Team stats"),
        for (final TeamGameStat stat in stats)
          // Faceoff wins repeat faceoff % as `43/70`.
          if (stat.category != "faceoffWins") _StatBar(stat: stat),
      ],
    );
  }
}

class const _StatBar({required final TeamGameStat stat})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const TextStyle valueStyle = AppTextStyles.paragraph2Bold;
    final double? awayShare = stat.awayShare;

    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(stat.awayText, style: valueStyle)),
              Text(
                stat.label,
                style: AppTextStyles.paragraph3.copyWith(
                  color: ref.textSecondary,
                ),
              ),
              Expanded(
                child: Text(stat.homeText, textAlign: .end, style: valueStyle),
              ),
            ],
          ),
          if (awayShare != null) ...[
            const SizedBox(height: spaceSM),
            Row(
              children: [
                // Grows from the centre towards the left edge.
                Expanded(
                  child: Transform.flip(
                    flipX: true,
                    child: LinearProgressIndicator(
                      value: awayShare,
                      color: ref.primary,
                    ),
                  ),
                ),
                const SizedBox(width: spaceMD),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1 - awayShare,
                    color: ref.accent,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
