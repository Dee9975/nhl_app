import "package:freezed_annotation/freezed_annotation.dart";

part "season_series_wins.freezed.dart";
part "season_series_wins.g.dart";

@freezed
@JsonSerializable()
class const SeasonSeriesWins({
  final int awayTeamWins = 0,
  final int homeTeamWins = 0,
}) with _$SeasonSeriesWins {
  factory fromJson(Map<String, dynamic> json) =>
      _$SeasonSeriesWinsFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonSeriesWinsToJson(this);
}
