import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "goal_assist.freezed.dart";
part "goal_assist.g.dart";

@freezed
@JsonSerializable()
class const GoalAssist({
  final int playerId = 0,
  final LocalizedName name = const LocalizedName(),
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final int assistsToDate = 0,
  final int sweaterNumber = 0,
}) with _$GoalAssist {
  factory fromJson(Map<String, dynamic> json) => _$GoalAssistFromJson(json);

  Map<String, dynamic> toJson() => _$GoalAssistToJson(this);
}
