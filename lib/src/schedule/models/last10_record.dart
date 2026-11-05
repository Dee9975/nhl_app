import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "last10_record.freezed.dart";
part "last10_record.g.dart";

/// A team's last ten games.
@freezed
@JsonSerializable()
class const Last10Record({
  /// `W-L-OTL`, e.g. `6-4-0`.
  final String record = "",

  /// `W`, `L` or `O` (overtime loss).
  final String streakType = "",
  final int streak = 0,

  /// Oldest first.
  final IList<PastGameResult> pastGameResults = const IListConst([]),
}) with _$Last10Record {
  factory fromJson(Map<String, dynamic> json) => _$Last10RecordFromJson(json);

  Map<String, dynamic> toJson() => _$Last10RecordToJson(this);
}
