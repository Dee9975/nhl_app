import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "series_game.freezed.dart";
part "series_game.g.dart";

/// A game between the same two teams this season.
@freezed
@JsonSerializable()
class const SeriesGame({
  final int id = 0,
  final DateTime? gameDate,
  final DateTime? startTimeUTC,
  @JsonKey(unknownEnumValue: GameState.unknown)
  final GameState gameState = .unknown,
  final String gameScheduleState = "",
  final SeriesTeam awayTeam = const SeriesTeam(),
  final SeriesTeam homeTeam = const SeriesTeam(),
  final PeriodDescriptor periodDescriptor = const PeriodDescriptor(),

  /// Only set once the game has ended.
  final GameOutcome? gameOutcome,
}) with _$SeriesGame {
  factory fromJson(Map<String, dynamic> json) => _$SeriesGameFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesGameToJson(this);
}
