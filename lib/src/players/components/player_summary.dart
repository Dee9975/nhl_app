import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

/// Bio, featured-season stats and career totals for one player.
///
/// Goalies get goalie stats (wins, GAA, save %); everyone else skater stats.
class const PlayerSummary({super.key, required final PlayerLanding player})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isGoalie = player.position == "G";
    final PlayerStats season = player.featuredStats.regularSeason.subSeason;
    final PlayerStats career = player.careerTotals.regularSeason;

    return Padding(
      padding: const .all(spaceXL),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text(
            "${StatFormat.season(player.featuredStats.season)} regular season",
            style: AppTextStyles.paragraph2Bold,
          ),
          const SizedBox(height: spaceMD),
          Row(
            children: switch (isGoalie) {
              true => [
                HeadlineStat(label: "GP", value: "${season.gamesPlayed}"),
                HeadlineStat(label: "W", value: "${season.wins}"),
                HeadlineStat(label: "L", value: "${season.losses}"),
                HeadlineStat(
                  label: "GAA",
                  value: season.goalsAgainstAvg.toStringAsFixed(2),
                ),
                HeadlineStat(
                  label: "SV%",
                  value: StatFormat.savePct(season.savePctg),
                ),
              ],
              false => [
                HeadlineStat(label: "GP", value: "${season.gamesPlayed}"),
                HeadlineStat(label: "G", value: "${season.goals}"),
                HeadlineStat(label: "A", value: "${season.assists}"),
                HeadlineStat(label: "PTS", value: "${season.points}"),
                HeadlineStat(
                  label: "+/-",
                  value: StatFormat.signed(season.plusMinus),
                ),
              ],
            },
          ),
          const Divider(height: spaceXXXL),
          StatRow(label: "Team", value: player.fullTeamName.value),
          StatRow(
            label: "Position",
            value: "${_position()} · #${player.sweaterNumber}",
          ),
          StatRow(
            label: switch (isGoalie) {
              true => "Catches",
              false => "Shoots",
            },
            value: player.shootsCatches,
          ),
          StatRow(
            label: "Height / weight",
            value:
                "${StatFormat.height(player.heightInInches)} / "
                "${player.weightInPounds} lb",
          ),
          StatRow(label: "Born", value: player.born),
          StatRow(label: "Draft", value: player.draftDetails.label),
          const Divider(height: spaceXXXL),
          const Text(
            "Career regular season",
            style: AppTextStyles.paragraph2Bold,
          ),
          const SizedBox(height: spaceMD),
          StatRow(label: "Games played", value: "${career.gamesPlayed}"),
          ...switch (isGoalie) {
            true => [
              StatRow(
                label: "Record",
                value: "${career.wins}-${career.losses}-${career.otLosses}",
              ),
              StatRow(
                label: "Goals against average",
                value: career.goalsAgainstAvg.toStringAsFixed(2),
              ),
              StatRow(
                label: "Save %",
                value: StatFormat.savePct(career.savePctg),
              ),
              StatRow(label: "Shutouts", value: "${career.shutouts}"),
            ],
            false => [
              StatRow(label: "Goals", value: "${career.goals}"),
              StatRow(label: "Assists", value: "${career.assists}"),
              StatRow(label: "Points", value: "${career.points}"),
              StatRow(
                label: "Plus/minus",
                value: StatFormat.signed(career.plusMinus),
              ),
              StatRow(
                label: "Power play goals",
                value: "${career.powerPlayGoals}",
              ),
              StatRow(
                label: "Game-winning goals",
                value: "${career.gameWinningGoals}",
              ),
              StatRow(
                label: "Shooting %",
                value: StatFormat.percent(career.shootingPctg),
              ),
              StatRow(label: "Avg. time on ice", value: career.avgToi),
            ],
          },
        ],
      ),
    );
  }

  String _position() {
    return switch (player.position) {
      "C" => "Center",
      "L" => "Left wing",
      "R" => "Right wing",
      "D" => "Defense",
      "G" => "Goalie",
      final String code => code,
    };
  }
}
