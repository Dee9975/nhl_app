import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/players/players.dart";

part "featured_stats.freezed.dart";
part "featured_stats.g.dart";

@freezed
@JsonSerializable()
class const FeaturedStats({
  /// Season as `yyyyyyyy`, e.g. `20262027`.
  final int season = 0,
  final StatsSplit regularSeason = const StatsSplit(),
  final StatsSplit playoffs = const StatsSplit(),
}) with _$FeaturedStats {
  factory fromJson(Map<String, dynamic> json) => _$FeaturedStatsFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturedStatsToJson(this);
}
