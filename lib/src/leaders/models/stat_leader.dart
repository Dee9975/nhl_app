import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "stat_leader.freezed.dart";
part "stat_leader.g.dart";

/// One player on a stats leaderboard, with their [value] in that category.
@freezed
@JsonSerializable()
class const StatLeader({
  final int id = 0,
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final int sweaterNumber = 0,
  final String headshot = "",
  final String teamAbbrev = "",
  final LocalizedName teamName = const LocalizedName(),
  final String teamLogo = "",

  /// `C`, `L`, `R`, `D` or `G`.
  final String position = "",

  /// A count for most categories; a fraction, average or seconds for some,
  /// see [SkaterLeaderCategory] and [GoalieLeaderCategory].
  final double value = 0,
}) with _$StatLeader {
  factory fromJson(Map<String, dynamic> json) => _$StatLeaderFromJson(json);

  Map<String, dynamic> toJson() => _$StatLeaderToJson(this);
}
