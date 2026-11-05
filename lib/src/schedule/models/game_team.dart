import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "game_team.freezed.dart";
part "game_team.g.dart";

/// A team in `GET /gamecenter/{id}/landing`.
@freezed
@JsonSerializable()
class const GameTeam({
  final int id = 0,
  final LocalizedName commonName = const LocalizedName(),
  final LocalizedName placeName = const LocalizedName(),
  final String abbrev = "",
  final String logo = "",
  final String darkLogo = "",

  /// Goals; null until the game has started.
  final int? score,

  /// Shots on goal; null until the game has started.
  final int? sog,

  /// `W-L-OTL` before the game, e.g. `10-6-0`.
  final String record = "",
}) with _$GameTeam {
  factory fromJson(Map<String, dynamic> json) => _$GameTeamFromJson(json);

  Map<String, dynamic> toJson() => _$GameTeamToJson(this);
}
