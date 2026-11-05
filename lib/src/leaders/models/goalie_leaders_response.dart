import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/leaders/leaders.dart";

part "goalie_leaders_response.freezed.dart";
part "goalie_leaders_response.g.dart";

/// Response of `GET /goalie-stats-leaders/current`, one leaderboard per
/// [GoalieLeaderCategory]. Categories that were not requested stay empty.
@freezed
@JsonSerializable()
class const GoalieLeadersResponse({
  final IList<StatLeader> wins = const IListConst([]),
  final IList<StatLeader> shutouts = const IListConst([]),
  final IList<StatLeader> savePctg = const IListConst([]),
  final IList<StatLeader> goalsAgainstAverage = const IListConst([]),
}) with _$GoalieLeadersResponse {
  factory fromJson(Map<String, dynamic> json) =>
      _$GoalieLeadersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoalieLeadersResponseToJson(this);

  /// The leaderboard for [category].
  IList<StatLeader> operator [](GoalieLeaderCategory category) {
    return switch (category) {
      .wins => wins,
      .shutouts => shutouts,
      .savePctg => savePctg,
      .goalsAgainstAverage => goalsAgainstAverage,
    };
  }
}
