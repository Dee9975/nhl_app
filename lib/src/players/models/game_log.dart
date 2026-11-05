import "package:freezed_annotation/freezed_annotation.dart";

part "game_log.freezed.dart";
part "game_log.g.dart";

/// One game from the player's recent games. Skaters fill the skater fields,
/// goalies the goalie fields; the rest keep their defaults.
@freezed
@JsonSerializable()
class const GameLog({
  final int gameId = 0,
  final DateTime? gameDate,
  final int gameTypeId = 0,
  final String teamAbbrev = "",
  final String opponentAbbrev = "",

  /// `H` for home, `R` for road.
  final String homeRoadFlag = "",
  final String toi = "",
  // Skater stats.
  final int goals = 0,
  final int assists = 0,
  final int points = 0,
  final int plusMinus = 0,
  final int powerPlayGoals = 0,
  final int shorthandedGoals = 0,
  final int shots = 0,
  final int shifts = 0,
  final int pim = 0,
  // Goalie stats.
  /// `W`, `L` or `O`.
  final String decision = "",
  final int gamesStarted = 0,
  final int goalsAgainst = 0,
  final int shotsAgainst = 0,
  final double savePctg = 0,
  final int penaltyMins = 0,
}) with _$GameLog {
  factory fromJson(Map<String, dynamic> json) => _$GameLogFromJson(json);

  Map<String, dynamic> toJson() => _$GameLogToJson(this);
}
