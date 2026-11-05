import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "schedule_response.freezed.dart";
part "schedule_response.g.dart";

/// Response of `GET /schedule/now`: the week starting today.
@freezed
@JsonSerializable()
class const ScheduleResponse({
  /// First day of the next week, for paging forward.
  final DateTime? nextStartDate,

  /// First day of the previous week, for paging back.
  final DateTime? previousStartDate,
  final IList<GameDay> gameWeek = const IListConst([]),
  final DateTime? preSeasonStartDate,
  final DateTime? regularSeasonStartDate,
  final DateTime? regularSeasonEndDate,
  final DateTime? playoffEndDate,

  /// Games in [gameWeek].
  final int numberOfGames = 0,
}) with _$ScheduleResponse {
  factory fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleResponseToJson(this);
}
