import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "team_season_stats_pair.freezed.dart";
part "team_season_stats_pair.g.dart";

@freezed
@JsonSerializable()
class const TeamSeasonStatsPair({
  /// e.g. `regular_season`.
  final String contextLabel = "",
  final TeamSeasonStats awayTeam = const TeamSeasonStats(),
  final TeamSeasonStats homeTeam = const TeamSeasonStats(),
}) with _$TeamSeasonStatsPair {
  factory fromJson(Map<String, dynamic> json) =>
      _$TeamSeasonStatsPairFromJson(json);

  Map<String, dynamic> toJson() => _$TeamSeasonStatsPairToJson(this);
}
