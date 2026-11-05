import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

part "team_standing.freezed.dart";
part "team_standing.g.dart";

@freezed
@JsonSerializable()
class const TeamStanding({
  final String conferenceName = "",
  final int conferenceSequence = 0,
  final String divisionName = "",
  final int divisionSequence = 0,
  final int gamesPlayed = 0,
  final int goalAgainst = 0,
  final int goalDifferential = 0,
  final int goalFor = 0,
  final int gameTypeId = 0,
  final int homeLosses = 0,
  final int homeOtLosses = 0,
  final int homeWins = 0,
  final int l10Losses = 0,
  final int l10OtLosses = 0,
  final int l10Wins = 0,
  final int leagueSequence = 0,
  final int losses = 0,
  final int otLosses = 0,
  final double pointPctg = 0,
  final int points = 0,
  final int roadLosses = 0,
  final int roadOtLosses = 0,
  final int roadWins = 0,
  final int seasonId = 0,
  @JsonKey(unknownEnumValue: StreakCode.unknown)
  final StreakCode streakCode = .unknown,
  final int streakCount = 0,
  final LocalizedName teamAbbrev = const LocalizedName(),
  final String teamLogo = "",
  final LocalizedName teamName = const LocalizedName(),
  final int wins = 0,
}) with _$TeamStanding {
  factory fromJson(Map<String, dynamic> json) => _$TeamStandingFromJson(json);

  Map<String, dynamic> toJson() => _$TeamStandingToJson(this);
}
