import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Group title plus one row per player, e.g. all forwards.
class const PlayerSection({
  super.key,
  required final String title,
  required final IList<RosterPlayer> players,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: PlayerGroupHeader(title: title, count: players.length),
        ),
        SliverList.separated(
          separatorBuilder: (context, i) {
            // Lines up with the player name, past the 56 px headshot.
            return const Divider(height: 1, indent: spaceXL + 56 + spaceXL);
          },
          itemBuilder: (context, i) {
            return PlayerRow(player: players[i]);
          },
          itemCount: players.length,
        ),
      ],
    );
  }
}
