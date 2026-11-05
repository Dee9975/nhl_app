import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "schedule_team.freezed.dart";
part "schedule_team.g.dart";

/// The home or away team of a scheduled game.
@freezed
@JsonSerializable()
class const ScheduleTeam({
  final int id = 0,
  final LocalizedName commonName = const LocalizedName(),
  final LocalizedName placeName = const LocalizedName(),
  final LocalizedName placeNameWithPreposition = const LocalizedName(),
  final String abbrev = "",
  final String logo = "",
  final String darkLogo = "",
  final String radioLink = "",

  /// Goals; null until the game has started.
  final int? score,
}) with _$ScheduleTeam {
  factory fromJson(Map<String, dynamic> json) => _$ScheduleTeamFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTeamToJson(this);
}
