import "package:freezed_annotation/freezed_annotation.dart";

part "goalie_totals.freezed.dart";
part "goalie_totals.g.dart";

/// A team's combined goaltending this season.
@freezed
@JsonSerializable()
class const GoalieTotals({
  /// `W-L-OTL`.
  final String record = "",
  final double gaa = 0,
  final double savePctg = 0,
  final int shutouts = 0,
  final int gamesPlayed = 0,
}) with _$GoalieTotals {
  factory fromJson(Map<String, dynamic> json) => _$GoalieTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$GoalieTotalsToJson(this);
}
