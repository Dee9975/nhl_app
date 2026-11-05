import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// Scoreboard header and the sections that fit the game's state:
/// matchup before the game, summary and team stats once it has started,
/// game info always.
class const GameDetailsView({
  super.key,
  required final GameLanding landing,
  required final GameRightRail rightRail,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool notPlayed = switch (landing.gameScheduleState) {
      "PPD" || "CNCL" => true,
      _ => false,
    };
    final bool started = switch (landing.gameState) {
      .live || .critical || .finished || .official => true,
      .future || .preGame || .unknown => false,
    };

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: GameHeaderDelegate(game: landing),
        ),
        if (!notPlayed && started) ...[
          SliverToBoxAdapter(
            child: GameSummarySection(landing: landing, rightRail: rightRail),
          ),
          if (rightRail.teamGameStats.isNotEmpty)
            SliverToBoxAdapter(
              child: TeamStatsComparison(stats: rightRail.teamGameStats),
            ),
        ],
        if (!notPlayed && !started)
          SliverToBoxAdapter(
            child: PreGameMatchup(landing: landing, rightRail: rightRail),
          ),
        SliverToBoxAdapter(
          child: GameInfoSection(landing: landing, rightRail: rightRail),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: spaceXXL)),
      ],
    );
  }
}
