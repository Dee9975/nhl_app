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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isGoalie = player.position == "G";
    final PlayerStats season = player.featuredStats.regularSeason.subSeason;
    final PlayerStats career = player.careerTotals.regularSeason;

    return Padding(
      padding: const .all(spaceXL),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text(
            "${_season(player.featuredStats.season)} regular season",
            style: textTheme.titleSmall,
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
                HeadlineStat(label: "SV%", value: _pctg(season.savePctg)),
              ],
              false => [
                HeadlineStat(label: "GP", value: "${season.gamesPlayed}"),
                HeadlineStat(label: "G", value: "${season.goals}"),
                HeadlineStat(label: "A", value: "${season.assists}"),
                HeadlineStat(label: "PTS", value: "${season.points}"),
                HeadlineStat(label: "+/-", value: _signed(season.plusMinus)),
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
            value: "${_height()} / ${player.weightInPounds} lb",
          ),
          StatRow(label: "Born", value: _born()),
          StatRow(label: "Draft", value: _draft()),
          const Divider(height: spaceXXXL),
          Text("Career regular season", style: textTheme.titleSmall),
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
              StatRow(label: "Save %", value: _pctg(career.savePctg)),
              StatRow(label: "Shutouts", value: "${career.shutouts}"),
            ],
            false => [
              StatRow(label: "Goals", value: "${career.goals}"),
              StatRow(label: "Assists", value: "${career.assists}"),
              StatRow(label: "Points", value: "${career.points}"),
              StatRow(label: "Plus/minus", value: _signed(career.plusMinus)),
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
                value: _percent(career.shootingPctg),
              ),
              StatRow(label: "Avg. time on ice", value: career.avgToi),
            ],
          },
        ],
      ),
    );
  }

  /// `20262027` as `2026-27`.
  String _season(int season) {
    final String text = "$season";
    return switch (text.length) {
      8 => "${text.substring(0, 4)}-${text.substring(6)}",
      _ => text,
    };
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

  /// Feet and inches, e.g. `6'2"`.
  String _height() {
    final int feet = player.heightInInches ~/ 12;
    final int inches = player.heightInInches % 12;
    return "$feet'$inches\"";
  }

  /// Birth date and place, e.g. `1997-01-13 · Richmond Hill, Ontario, CAN`.
  String _born() {
    final String date = switch (player.birthDate) {
      null => "",
      final DateTime d =>
        "${d.year}-${d.month.toString().padLeft(2, "0")}-"
            "${d.day.toString().padLeft(2, "0")}",
    };
    final String place = [
      player.birthCity.value,
      player.birthStateProvince.value,
      player.birthCountry,
    ].where((part) => part.isNotEmpty).join(", ");

    return [date, place].where((part) => part.isNotEmpty).join(" · ");
  }

  /// e.g. `2015 EDM, round 1, #1 overall`, or `Undrafted`.
  String _draft() {
    final DraftDetails draft = player.draftDetails;
    return switch (draft.year) {
      0 => "Undrafted",
      _ =>
        "${draft.year} ${draft.teamAbbrev}, round ${draft.round}, "
            "#${draft.overallPick} overall",
    };
  }

  /// Adds a leading `+` to positive numbers.
  String _signed(int value) {
    return switch (value) {
      > 0 => "+$value",
      _ => "$value",
    };
  }

  /// Save percentage the hockey way, e.g. `.913`.
  String _pctg(double value) {
    return value.toStringAsFixed(3).replaceFirst("0.", ".");
  }

  /// Fraction as a percentage, e.g. `0.1516` as `15.2%`.
  String _percent(double value) {
    return "${(value * 100).toStringAsFixed(1)}%";
  }
}
