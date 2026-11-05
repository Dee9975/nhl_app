import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "period_scoring.freezed.dart";
part "period_scoring.g.dart";

/// Goals scored in one period.
@freezed
@JsonSerializable()
class const PeriodScoring({
  final PeriodDescriptor periodDescriptor = const PeriodDescriptor(),
  final IList<GoalEvent> goals = const IListConst([]),
}) with _$PeriodScoring {
  factory fromJson(Map<String, dynamic> json) => _$PeriodScoringFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodScoringToJson(this);
}
