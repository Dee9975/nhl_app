import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "teammate.freezed.dart";
part "teammate.g.dart";

/// A player on the current team's roster, from `currentTeamRoster`.
@freezed
@JsonSerializable()
class const Teammate({
  final int playerId = 0,
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final String playerSlug = "",
}) with _$Teammate {
  factory fromJson(Map<String, dynamic> json) => _$TeammateFromJson(json);

  Map<String, dynamic> toJson() => _$TeammateToJson(this);
}
