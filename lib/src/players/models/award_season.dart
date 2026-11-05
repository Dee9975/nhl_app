import "package:freezed_annotation/freezed_annotation.dart";

part "award_season.freezed.dart";
part "award_season.g.dart";

/// The player's stats in a season they won an award. Skaters fill the skater
/// fields, goalies the goalie fields; the rest keep their defaults.
@freezed
@JsonSerializable()
class const AwardSeason({
  /// Season as `yyyyyyyy`, e.g. `20252026`.
  final int seasonId = 0,
  final int gameTypeId = 0,
  final int gamesPlayed = 0,
  // Skater stats.
  final int goals = 0,
  final int assists = 0,
  final int points = 0,
  final int plusMinus = 0,
  final int pim = 0,
  final int hits = 0,
  final int blockedShots = 0,
  // Goalie stats.
  final int wins = 0,
  final int losses = 0,
  final int otLosses = 0,
  final double gaa = 0,
  final double savePctg = 0,
}) with _$AwardSeason {
  factory fromJson(Map<String, dynamic> json) => _$AwardSeasonFromJson(json);

  Map<String, dynamic> toJson() => _$AwardSeasonToJson(this);
}
