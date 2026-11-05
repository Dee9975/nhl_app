import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "goalie_team_comparison.freezed.dart";
part "goalie_team_comparison.g.dart";

@freezed
@JsonSerializable()
class const GoalieTeamComparison({
  final GoalieTotals teamTotals = const GoalieTotals(),
  final IList<MatchupGoalie> leaders = const IListConst([]),
}) with _$GoalieTeamComparison {
  factory fromJson(Map<String, dynamic> json) =>
      _$GoalieTeamComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$GoalieTeamComparisonToJson(this);
}
