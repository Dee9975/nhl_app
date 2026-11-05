import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "last10_record_pair.freezed.dart";
part "last10_record_pair.g.dart";

@freezed
@JsonSerializable()
class const Last10RecordPair({
  final Last10Record awayTeam = const Last10Record(),
  final Last10Record homeTeam = const Last10Record(),
}) with _$Last10RecordPair {
  factory fromJson(Map<String, dynamic> json) =>
      _$Last10RecordPairFromJson(json);

  Map<String, dynamic> toJson() => _$Last10RecordPairToJson(this);
}
