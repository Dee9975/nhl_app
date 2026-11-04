import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Season summary for one team: record, points, goals, splits and ranks.
class const TeamStats({super.key, required final TeamStanding standing})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const .all(spaceXL),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              _HeadlineStat(label: "GP", value: "${standing.gamesPlayed}"),
              _HeadlineStat(label: "W", value: "${standing.wins}"),
              _HeadlineStat(label: "L", value: "${standing.losses}"),
              _HeadlineStat(label: "OTL", value: "${standing.otLosses}"),
              _HeadlineStat(label: "PTS", value: "${standing.points}"),
            ],
          ),
          const Divider(height: spaceXXXL),
          _StatRow(
            label: "Points %",
            value: standing.pointPctg.toStringAsFixed(3),
          ),
          _StatRow(
            label: "Goals for / against",
            value: "${standing.goalFor} / ${standing.goalAgainst}",
          ),
          _StatRow(
            label: "Goal differential",
            value: _signed(standing.goalDifferential),
          ),
          _StatRow(
            label: "Home",
            value: _record(
              standing.homeWins,
              standing.homeLosses,
              standing.homeOtLosses,
            ),
          ),
          _StatRow(
            label: "Road",
            value: _record(
              standing.roadWins,
              standing.roadLosses,
              standing.roadOtLosses,
            ),
          ),
          _StatRow(
            label: "Last 10",
            value: _record(
              standing.l10Wins,
              standing.l10Losses,
              standing.l10OtLosses,
            ),
          ),
          _StatRow(label: "Streak", value: _streak()),
          const Divider(height: spaceXXXL),
          Text("Standings", style: textTheme.titleSmall),
          const SizedBox(height: spaceMD),
          _StatRow(
            label: standing.divisionName,
            value: _ordinal(standing.divisionSequence),
          ),
          _StatRow(
            label: standing.conferenceName,
            value: _ordinal(standing.conferenceSequence),
          ),
          _StatRow(label: "League", value: _ordinal(standing.leagueSequence)),
        ],
      ),
    );
  }

  /// `W-L-OT`, e.g. `7-2-1`.
  String _record(int wins, int losses, int otLosses) {
    return "$wins-$losses-$otLosses";
  }

  /// Adds a leading `+` to positive numbers.
  String _signed(int value) {
    return switch (value) {
      > 0 => "+$value",
      _ => "$value",
    };
  }

  /// Current streak, e.g. `W3`, or `-` when unknown.
  String _streak() {
    final String code = switch (standing.streakCode) {
      .win => "W",
      .loss => "L",
      .overtimeLoss => "OT",
      .unknown => "",
    };

    return switch (code) {
      "" => "-",
      _ => "$code${standing.streakCount}",
    };
  }

  /// `1st`, `2nd`, `3rd`, `4th` ... `11th`, `12th`, `13th`, `21st`.
  String _ordinal(int n) {
    final String suffix = switch ((n % 100, n % 10)) {
      (11 || 12 || 13, _) => "th",
      (_, 1) => "st",
      (_, 2) => "nd",
      (_, 3) => "rd",
      _ => "th",
    };

    return "$n$suffix";
  }
}

class const _HeadlineStat({
  required final String label,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(fontWeight: .bold),
          ),
          Text(label, style: textTheme.labelMedium),
        ],
      ),
    );
  }
}

class const _StatRow({required final String label, required final String value})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const .symmetric(vertical: spaceSM),
      child: Row(
        children: [
          Expanded(child: Text(label, style: textTheme.bodyMedium)),
          Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: .w600)),
        ],
      ),
    );
  }
}
