import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "skater_comparison.freezed.dart";
part "skater_comparison.g.dart";

@freezed
@JsonSerializable()
class const SkaterComparison({
  /// e.g. `last_5_games`.
  final String contextLabel = "",
  final IList<SkaterLeaderPair> leaders = const IListConst([]),
}) with _$SkaterComparison {
  factory fromJson(Map<String, dynamic> json) =>
      _$SkaterComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$SkaterComparisonToJson(this);
}
