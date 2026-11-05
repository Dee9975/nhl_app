import "package:freezed_annotation/freezed_annotation.dart";

part "series_team.freezed.dart";
part "series_team.g.dart";

@freezed
@JsonSerializable()
class const SeriesTeam({
  final int id = 0,
  final String abbrev = "",
  final String logo = "",

  /// Goals; null until the game has started.
  final int? score,
}) with _$SeriesTeam {
  factory fromJson(Map<String, dynamic> json) => _$SeriesTeamFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesTeamToJson(this);
}
