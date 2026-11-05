import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/players/players.dart";

part "career_totals.freezed.dart";
part "career_totals.g.dart";

@freezed
@JsonSerializable()
class const CareerTotals({
  final PlayerStats regularSeason = const PlayerStats(),
  final PlayerStats playoffs = const PlayerStats(),
}) with _$CareerTotals {
  factory fromJson(Map<String, dynamic> json) => _$CareerTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$CareerTotalsToJson(this);
}
