import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_day.freezed.dart";
part "game_day.g.dart";

/// One day of the schedule and its games.
@freezed
@JsonSerializable()
class const GameDay({
  final DateTime? date,

  /// e.g. `FRI`.
  final String dayAbbrev = "",
  final int numberOfGames = 0,
  final IList<ScheduleGame> games = const IListConst([]),
}) with _$GameDay {
  factory fromJson(Map<String, dynamic> json) => _$GameDayFromJson(json);

  Map<String, dynamic> toJson() => _$GameDayToJson(this);
}
