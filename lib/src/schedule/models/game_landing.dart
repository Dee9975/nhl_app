import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "game_landing.freezed.dart";
part "game_landing.g.dart";

/// Response of `GET /gamecenter/{id}/landing`.
@freezed
@JsonSerializable()
class const GameLanding({
  final int id = 0,

  /// Season as `yyyyyyyy`, e.g. `20262027`.
  final int season = 0,
  final int gameType = 0,
  final DateTime? gameDate,
  final LocalizedName venue = const LocalizedName(),
  final LocalizedName venueLocation = const LocalizedName(),
  final DateTime? startTimeUTC,
  final String venueTimezone = "",
  @JsonKey(unknownEnumValue: GameState.unknown)
  final GameState gameState = .unknown,

  /// `OK` unless the game was postponed (`PPD`) or cancelled (`CNCL`).
  final String gameScheduleState = "",
  final PeriodDescriptor periodDescriptor = const PeriodDescriptor(),
  final IList<TvBroadcast> tvBroadcasts = const IListConst([]),
  final GameTeam awayTeam = const GameTeam(),
  final GameTeam homeTeam = const GameTeam(),
  final GameClock clock = const GameClock(),

  /// Only set once the game has started.
  final GameSummary? summary,

  /// Only set before the game.
  final GameMatchup? matchup,
}) with _$GameLanding {
  factory fromJson(Map<String, dynamic> json) => _$GameLandingFromJson(json);

  Map<String, dynamic> toJson() => _$GameLandingToJson(this);
}
