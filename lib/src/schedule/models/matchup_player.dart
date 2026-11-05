import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "matchup_player.freezed.dart";
part "matchup_player.g.dart";

/// A skater in a pre-game comparison, with their [value] in the category.
@freezed
@JsonSerializable()
class const MatchupPlayer({
  final int playerId = 0,
  final LocalizedName name = const LocalizedName(),
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final int sweaterNumber = 0,
  final String positionCode = "",
  final String headshot = "",
  final double value = 0,
}) with _$MatchupPlayer {
  factory fromJson(Map<String, dynamic> json) => _$MatchupPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$MatchupPlayerToJson(this);
}
