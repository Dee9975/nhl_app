import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "roster_player.freezed.dart";
part "roster_player.g.dart";

@freezed
@JsonSerializable()
class const RosterPlayer({
  final int id = 0,
  final String headshot = "",
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final int sweaterNumber = 0,
  final String positionCode = "",
  final String shootsCatches = "",
}) with _$RosterPlayer {
  factory fromJson(Map<String, dynamic> json) => _$RosterPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$RosterPlayerToJson(this);
}
