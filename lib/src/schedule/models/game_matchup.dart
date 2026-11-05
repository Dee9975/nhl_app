import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_matchup.freezed.dart";
part "game_matchup.g.dart";

/// Pre-game comparison of the two teams' leaders.
@freezed
@JsonSerializable()
class const GameMatchup({
  final SkaterComparison skaterComparison = const SkaterComparison(),
  final GoalieComparison goalieComparison = const GoalieComparison(),
}) with _$GameMatchup {
  factory fromJson(Map<String, dynamic> json) => _$GameMatchupFromJson(json);

  Map<String, dynamic> toJson() => _$GameMatchupToJson(this);
}
