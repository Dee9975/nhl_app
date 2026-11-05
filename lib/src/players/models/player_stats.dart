import "package:freezed_annotation/freezed_annotation.dart";

part "player_stats.freezed.dart";
part "player_stats.g.dart";

/// Stat totals for a span of games. Skaters fill the skater fields, goalies
/// the goalie fields; the rest keep their defaults.
@freezed
@JsonSerializable()
class const PlayerStats({
  final int gamesPlayed = 0,
  final int goals = 0,
  final int assists = 0,
  final int pim = 0,
  // Skater stats.
  final int points = 0,
  final int plusMinus = 0,
  final int gameWinningGoals = 0,
  final int otGoals = 0,
  final int powerPlayGoals = 0,
  final int powerPlayPoints = 0,
  final int shorthandedGoals = 0,
  final int shorthandedPoints = 0,
  final int shots = 0,
  final double shootingPctg = 0,
  final double faceoffWinningPctg = 0,
  final String avgToi = "",
  // Goalie stats.
  final int gamesStarted = 0,
  final int wins = 0,
  final int losses = 0,
  final int otLosses = 0,
  final int ties = 0,
  final int shutouts = 0,
  final int goalsAgainst = 0,
  final double goalsAgainstAvg = 0,
  final int shotsAgainst = 0,
  final double savePctg = 0,
  final String timeOnIce = "",
}) with _$PlayerStats {
  factory fromJson(Map<String, dynamic> json) => _$PlayerStatsFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerStatsToJson(this);
}
