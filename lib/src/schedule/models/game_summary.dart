import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_summary.freezed.dart";
part "game_summary.g.dart";

/// Scoring and three stars, once the game has started.
@freezed
@JsonSerializable()
class const GameSummary({
  final IList<PeriodScoring> scoring = const IListConst([]),
  final IList<ThreeStar> threeStars = const IListConst([]),
}) with _$GameSummary {
  factory fromJson(Map<String, dynamic> json) => _$GameSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$GameSummaryToJson(this);
}
