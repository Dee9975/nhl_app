import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/players/players.dart";

part "stats_split.freezed.dart";
part "stats_split.g.dart";

/// Stats for the featured season next to career stats, for one game type.
@freezed
@JsonSerializable()
class const StatsSplit({
  final PlayerStats subSeason = const PlayerStats(),
  final PlayerStats career = const PlayerStats(),
}) with _$StatsSplit {
  factory fromJson(Map<String, dynamic> json) => _$StatsSplitFromJson(json);

  Map<String, dynamic> toJson() => _$StatsSplitToJson(this);
}
