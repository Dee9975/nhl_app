import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "linescore.freezed.dart";
part "linescore.g.dart";

/// Goals per period.
@freezed
@JsonSerializable()
class const Linescore({
  final IList<PeriodLine> byPeriod = const IListConst([]),
  final LinescoreTotals totals = const LinescoreTotals(),
}) with _$Linescore {
  factory fromJson(Map<String, dynamic> json) => _$LinescoreFromJson(json);

  Map<String, dynamic> toJson() => _$LinescoreToJson(this);
}
