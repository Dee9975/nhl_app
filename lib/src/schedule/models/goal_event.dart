import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "goal_event.freezed.dart";
part "goal_event.g.dart";

/// One goal in the scoring summary.
@freezed
@JsonSerializable()
class const GoalEvent({
  final int playerId = 0,
  final LocalizedName name = const LocalizedName(),
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final LocalizedName teamAbbrev = const LocalizedName(),

  /// e.g. `14:40`.
  final String timeInPeriod = "",

  /// `ev`, `pp` or `sh`.
  final String strength = "",

  /// e.g. `none` or `empty-net`.
  final String goalModifier = "",
  final int goalsToDate = 0,
  final String shotType = "",
  final int awayScore = 0,
  final int homeScore = 0,
  final bool isHome = false,
  final String headshot = "",
  final IList<GoalAssist> assists = const IListConst([]),
}) with _$GoalEvent {
  factory fromJson(Map<String, dynamic> json) => _$GoalEventFromJson(json);

  Map<String, dynamic> toJson() => _$GoalEventToJson(this);
}
