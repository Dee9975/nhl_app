import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// A group's header and column labels, pinned while its teams scroll, plus
/// one row per team.
class const StandingsSection({
  super.key,
  required final StandingsGroup group,
  final ValueChanged<TeamStanding>? onTeamTap,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverMainAxisGroup(
      slivers: [
        PinnedHeaderSliver(
          child: ColoredBox(
            color: ref.surface,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                SectionHeader(title: group.name, count: group.teams.length),
                const StandingsColumnHeader(),
              ],
            ),
          ),
        ),
        SliverList.separated(
          separatorBuilder: (context, i) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final RankedTeam team = group.teams[i];

            return TeamRow(
              rank: team.rank,
              standing: team.standing,
              onTap: switch (onTeamTap) {
                null => null,
                final ValueChanged<TeamStanding> onTap => () => onTap(
                  team.standing,
                ),
              },
            );
          },
          itemCount: group.teams.length,
        ),
      ],
    );
  }
}
