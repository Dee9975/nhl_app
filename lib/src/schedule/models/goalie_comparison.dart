import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "goalie_comparison.freezed.dart";
part "goalie_comparison.g.dart";

@freezed
@JsonSerializable()
class const GoalieComparison({
  final GoalieTeamComparison awayTeam = const GoalieTeamComparison(),
  final GoalieTeamComparison homeTeam = const GoalieTeamComparison(),
}) with _$GoalieComparison {
  factory fromJson(Map<String, dynamic> json) =>
      _$GoalieComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$GoalieComparisonToJson(this);
}
