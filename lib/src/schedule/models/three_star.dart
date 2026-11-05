import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "three_star.freezed.dart";
part "three_star.g.dart";

/// One of the game's three stars. Skaters fill the skater fields, goalies
/// the goalie fields.
@freezed
@JsonSerializable()
class const ThreeStar({
  /// 1, 2 or 3.
  final int star = 0,
  final int playerId = 0,
  final String teamAbbrev = "",
  final String headshot = "",
  final LocalizedName name = const LocalizedName(),
  final int sweaterNo = 0,

  /// `C`, `L`, `R`, `D` or `G`.
  final String position = "",
  // Skater stats.
  final int goals = 0,
  final int assists = 0,
  final int points = 0,
  // Goalie stats.
  final double goalsAgainstAverage = 0,
  final double savePctg = 0,
}) with _$ThreeStar {
  factory fromJson(Map<String, dynamic> json) => _$ThreeStarFromJson(json);

  Map<String, dynamic> toJson() => _$ThreeStarToJson(this);
}
