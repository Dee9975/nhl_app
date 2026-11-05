import "package:freezed_annotation/freezed_annotation.dart";

part "past_game_result.freezed.dart";
part "past_game_result.g.dart";

@freezed
@JsonSerializable()
class const PastGameResult({
  final String opponentAbbrev = "",

  /// `W`, `L`, `OTW`, `OTL`, `SOW` or `SOL`.
  final String gameResult = "",
}) with _$PastGameResult {
  factory fromJson(Map<String, dynamic> json) => _$PastGameResultFromJson(json);

  Map<String, dynamic> toJson() => _$PastGameResultToJson(this);
}
