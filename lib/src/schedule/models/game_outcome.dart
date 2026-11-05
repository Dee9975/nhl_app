import "package:freezed_annotation/freezed_annotation.dart";

part "game_outcome.freezed.dart";
part "game_outcome.g.dart";

/// How a finished game ended.
@freezed
@JsonSerializable()
class const GameOutcome({
  /// `REG`, `OT` or `SO`.
  final String lastPeriodType = "",
}) with _$GameOutcome {
  factory fromJson(Map<String, dynamic> json) => _$GameOutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$GameOutcomeToJson(this);
}
