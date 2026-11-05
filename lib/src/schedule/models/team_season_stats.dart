import "package:freezed_annotation/freezed_annotation.dart";

part "team_season_stats.freezed.dart";
part "team_season_stats.g.dart";

/// A team's season stats with league ranks (1 is best).
@freezed
@JsonSerializable()
class const TeamSeasonStats({
  final double ppPctg = 0,
  final int ppPctgRank = 0,
  final double pkPctg = 0,
  final int pkPctgRank = 0,
  final double faceoffWinningPctg = 0,
  final int faceoffWinningPctgRank = 0,
  final double goalsForPerGamePlayed = 0,
  final int goalsForPerGamePlayedRank = 0,
  final double goalsAgainstPerGamePlayed = 0,
  final int goalsAgainstPerGamePlayedRank = 0,
}) with _$TeamSeasonStats {
  factory fromJson(Map<String, dynamic> json) =>
      _$TeamSeasonStatsFromJson(json);

  Map<String, dynamic> toJson() => _$TeamSeasonStatsToJson(this);
}
