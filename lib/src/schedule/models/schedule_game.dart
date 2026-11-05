import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "schedule_game.freezed.dart";
part "schedule_game.g.dart";

@freezed
@JsonSerializable()
class const ScheduleGame({
  final int id = 0,

  /// Season as `yyyyyyyy`, e.g. `20262027`.
  final int season = 0,

  /// 1 preseason, 2 regular season, 3 playoffs.
  final int gameType = 0,
  final LocalizedName venue = const LocalizedName(),
  final bool neutralSite = false,
  final DateTime? startTimeUTC,
  final String easternUTCOffset = "",
  final String venueUTCOffset = "",
  final String venueTimezone = "",
  @JsonKey(unknownEnumValue: GameState.unknown)
  final GameState gameState = .unknown,

  /// `OK` unless the game was postponed or cancelled.
  final String gameScheduleState = "",
  final IList<TvBroadcast> tvBroadcasts = const IListConst([]),
  final ScheduleTeam awayTeam = const ScheduleTeam(),
  final ScheduleTeam homeTeam = const ScheduleTeam(),
  final PeriodDescriptor periodDescriptor = const PeriodDescriptor(),

  /// Only set once the game has ended.
  final GameOutcome? gameOutcome,

  /// Only set once the game has ended.
  final GamePlayer? winningGoalScorer,

  /// Only set once the game has ended.
  final GamePlayer? winningGoalie,
  final String ticketsLink = "",

  /// Path on nhl.com, e.g. `/gamecenter/ana-vs-cgy/2026/11/06/2026020264`.
  final String gameCenterLink = "",

  /// Video path on nhl.com, once the game has ended.
  final String threeMinRecap = "",

  /// Video path on nhl.com, once the game has ended.
  final String condensedGame = "",
}) with _$ScheduleGame {
  factory fromJson(Map<String, dynamic> json) => _$ScheduleGameFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleGameToJson(this);
}
