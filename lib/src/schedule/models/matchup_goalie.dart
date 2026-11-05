import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "matchup_goalie.freezed.dart";
part "matchup_goalie.g.dart";

/// A goalie in a pre-game comparison, with their season stats.
@freezed
@JsonSerializable()
class const MatchupGoalie({
  final int playerId = 0,
  final LocalizedName name = const LocalizedName(),
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final int sweaterNumber = 0,
  final String headshot = "",
  final int gamesPlayed = 0,

  /// `W-L-OTL`.
  final String record = "",
  final double gaa = 0,
  final double savePctg = 0,
  final int shutouts = 0,
}) with _$MatchupGoalie {
  factory fromJson(Map<String, dynamic> json) => _$MatchupGoalieFromJson(json);

  Map<String, dynamic> toJson() => _$MatchupGoalieToJson(this);
}
