import "package:freezed_annotation/freezed_annotation.dart";

part "linescore_totals.freezed.dart";
part "linescore_totals.g.dart";

@freezed
@JsonSerializable()
class const LinescoreTotals({final int away = 0, final int home = 0})
    with _$LinescoreTotals {
  factory fromJson(Map<String, dynamic> json) =>
      _$LinescoreTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$LinescoreTotalsToJson(this);
}
