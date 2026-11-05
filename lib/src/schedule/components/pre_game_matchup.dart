import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// Records, recent form, season ranks and each team's leaders before the
/// game.
class const PreGameMatchup({
  super.key,
  required final GameLanding landing,
  required final GameRightRail rightRail,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Last10RecordPair? last10 = rightRail.last10Record;
    final TeamSeasonStatsPair? seasonStats = rightRail.teamSeasonStats;
    final GameMatchup? matchup = landing.matchup;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: "Matchup"),
        Padding(
          padding: const .symmetric(horizontal: spaceXL),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              ComparisonRow(
                label: "Record",
                away: landing.awayTeam.record,
                home: landing.homeTeam.record,
              ),
              if (last10 != null) ...[
                ComparisonRow(
                  label: "Last 10",
                  away: last10.awayTeam.record,
                  home: last10.homeTeam.record,
                ),
                ComparisonRow(
                  label: "Streak",
                  away: _streak(last10.awayTeam),
                  home: _streak(last10.homeTeam),
                ),
                Padding(
                  padding: const .symmetric(vertical: spaceSM),
                  child: Row(
                    children: [
                      _FormDots(record: last10.awayTeam),
                      const Spacer(),
                      _FormDots(record: last10.homeTeam),
                    ],
                  ),
                ),
              ],
              if (seasonStats != null) ...[
                ComparisonRow(
                  label: "Power play",
                  away: _ranked(
                    seasonStats.awayTeam.ppPctg,
                    seasonStats.awayTeam.ppPctgRank,
                  ),
                  home: _ranked(
                    seasonStats.homeTeam.ppPctg,
                    seasonStats.homeTeam.ppPctgRank,
                  ),
                ),
                ComparisonRow(
                  label: "Penalty kill",
                  away: _ranked(
                    seasonStats.awayTeam.pkPctg,
                    seasonStats.awayTeam.pkPctgRank,
                  ),
                  home: _ranked(
                    seasonStats.homeTeam.pkPctg,
                    seasonStats.homeTeam.pkPctgRank,
                  ),
                ),
                ComparisonRow(
                  label: "Faceoff %",
                  away: _ranked(
                    seasonStats.awayTeam.faceoffWinningPctg,
                    seasonStats.awayTeam.faceoffWinningPctgRank,
                  ),
                  home: _ranked(
                    seasonStats.homeTeam.faceoffWinningPctg,
                    seasonStats.homeTeam.faceoffWinningPctgRank,
                  ),
                ),
                ComparisonRow(
                  label: "Goals for / game",
                  away: _rankedNumber(
                    seasonStats.awayTeam.goalsForPerGamePlayed,
                    seasonStats.awayTeam.goalsForPerGamePlayedRank,
                  ),
                  home: _rankedNumber(
                    seasonStats.homeTeam.goalsForPerGamePlayed,
                    seasonStats.homeTeam.goalsForPerGamePlayedRank,
                  ),
                ),
                ComparisonRow(
                  label: "Goals against / game",
                  away: _rankedNumber(
                    seasonStats.awayTeam.goalsAgainstPerGamePlayed,
                    seasonStats.awayTeam.goalsAgainstPerGamePlayedRank,
                  ),
                  home: _rankedNumber(
                    seasonStats.homeTeam.goalsAgainstPerGamePlayed,
                    seasonStats.homeTeam.goalsAgainstPerGamePlayedRank,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (matchup != null) ...[
          if (matchup.skaterComparison.leaders.isNotEmpty) ...[
            SectionHeader(
              title: "Leaders · ${_context(matchup.skaterComparison)}",
            ),
            for (final SkaterLeaderPair pair
                in matchup.skaterComparison.leaders)
              _LeaderPairRow(pair: pair),
          ],
          if (matchup.goalieComparison.awayTeam.leaders.isNotEmpty ||
              matchup.goalieComparison.homeTeam.leaders.isNotEmpty) ...[
            const SectionHeader(title: "Goalies"),
            _GoaliePairRow(comparison: matchup.goalieComparison),
          ],
        ],
      ],
    );
  }

  /// e.g. `W2`, `L1`, `OT1`.
  String _streak(Last10Record record) {
    final String type = switch (record.streakType) {
      "O" => "OT",
      final String type => type,
    };
    return switch (type) {
      "" => "–",
      _ => "$type${record.streak}",
    };
  }

  /// Fraction and league rank, e.g. `36.4% (2nd)`.
  String _ranked(double fraction, int rank) {
    return "${StatFormat.percent(fraction)} (${StatFormat.ordinal(rank)})";
  }

  /// Number and league rank, e.g. `3.56 (7th)`.
  String _rankedNumber(double value, int rank) {
    return "${value.toStringAsFixed(2)} (${StatFormat.ordinal(rank)})";
  }

  /// `last_5_games` as `last 5 games`.
  String _context(SkaterComparison comparison) {
    return comparison.contextLabel.replaceAll("_", " ");
  }
}

/// One dot per game of the last ten, oldest first: filled for wins, red for
/// regulation losses, outlined for overtime and shootout losses.
class const _FormDots({required final Last10Record record})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: .min,
      children: [
        for (final PastGameResult result in record.pastGameResults)
          Padding(
            padding: const .only(right: spaceSM),
            child: Tooltip(
              message: "${result.gameResult} vs ${result.opponentAbbrev}",
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: switch (result.gameResult) {
                    "W" || "OTW" || "SOW" => ref.primary,
                    "L" => ref.error,
                    _ => null,
                  },
                  border: Border.all(color: ref.outline),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Each team's leader in one category, mirrored around the category name.
class const _LeaderPairRow({required final SkaterLeaderPair pair})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Row(
        children: [
          Expanded(
            child: _MatchupPerson(player: pair.awayLeader, isHome: false),
          ),
          Text(switch (pair.category) {
            "points" => "PTS",
            "goals" => "G",
            "assists" => "A",
            final String other => other,
          }, style: AppTextStyles.paragraph3),
          Expanded(
            child: _MatchupPerson(player: pair.homeLeader, isHome: true),
          ),
        ],
      ),
    );
  }
}

/// Headshot, name and value; mirrored for the home team.
class const _MatchupPerson({
  required final MatchupPlayer player,
  required final bool isHome,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      PlayerHeadshot(url: player.headshot),
      const SizedBox(width: spaceMD),
      Flexible(
        child: Column(
          crossAxisAlignment: isHome ? .end : .start,
          children: [
            Text(
              player.name.value,
              maxLines: 1,
              overflow: .ellipsis,
              style: AppTextStyles.paragraph3,
            ),
            Text("${player.value.round()}", style: AppTextStyles.title3Bold),
          ],
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: isHome ? .end : .start,
      children: isHome ? children.reversed.toList() : children,
    );
  }
}

/// Each team's top goalie (most games) with record, GAA and save %.
class const _GoaliePairRow({required final GoalieComparison comparison})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: _GoalieColumn(team: comparison.awayTeam, isHome: false),
          ),
          const SizedBox(width: spaceXL),
          Expanded(
            child: _GoalieColumn(team: comparison.homeTeam, isHome: true),
          ),
        ],
      ),
    );
  }
}

class const _GoalieColumn({
  required final GoalieTeamComparison team,
  required final bool isHome,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (team.leaders.isEmpty) {
      return const SizedBox.shrink();
    }
    final MatchupGoalie goalie = team.leaders.reduce(
      (a, b) => a.gamesPlayed >= b.gamesPlayed ? a : b,
    );
    final String savePct = StatFormat.savePct(goalie.savePctg);

    return Column(
      crossAxisAlignment: isHome ? .end : .start,
      children: [
        PlayerHeadshot(url: goalie.headshot),
        const SizedBox(height: spaceSM),
        Text(goalie.name.value, style: AppTextStyles.paragraph2Bold),
        Text(
          "${goalie.record} · ${goalie.gaa.toStringAsFixed(2)} GAA · "
          "$savePct",
          textAlign: isHome ? .end : .start,
          style: AppTextStyles.paragraph3,
        ),
      ],
    );
  }
}
