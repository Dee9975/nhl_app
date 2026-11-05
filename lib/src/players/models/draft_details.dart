import "package:freezed_annotation/freezed_annotation.dart";

part "draft_details.freezed.dart";
part "draft_details.g.dart";

@freezed
@JsonSerializable()
class const DraftDetails({
  final int year = 0,
  final String teamAbbrev = "",
  final int round = 0,
  final int pickInRound = 0,
  final int overallPick = 0,
}) with _$DraftDetails {
  factory fromJson(Map<String, dynamic> json) => _$DraftDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DraftDetailsToJson(this);
}
