import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_right_rail.freezed.dart";
part "game_right_rail.g.dart";

/// Response of `GET /gamecenter/{id}/right-rail`.
@freezed
@JsonSerializable()
class const GameRightRail({
  final IList<SeriesGame> seasonSeries = const IListConst([]),
  final SeasonSeriesWins seasonSeriesWins = const SeasonSeriesWins(),
  @JsonKey(name: "gameInfo")
  final GameOfficials officials = const GameOfficials(),

  /// Only set once the game has started.
  final Linescore? linescore,
  final IList<PeriodLine> shotsByPeriod = const IListConst([]),
  final IList<TeamGameStat> teamGameStats = const IListConst([]),

  /// Only set before the game.
  final TeamSeasonStatsPair? teamSeasonStats,

  /// Only set before the game.
  final Last10RecordPair? last10Record,
}) with _$GameRightRail {
  factory fromJson(Map<String, dynamic> json) => _$GameRightRailFromJson(json);

  Map<String, dynamic> toJson() => _$GameRightRailToJson(this);
}
