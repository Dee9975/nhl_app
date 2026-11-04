import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/teams/teams.dart";

part "standings_response.freezed.dart";
part "standings_response.g.dart";

@freezed
@JsonSerializable()
class const StandingsResponse({
  final IList<TeamStanding> standings = const IListConst([]),
}) with _$StandingsResponse {
  factory fromJson(Map<String, dynamic> json) =>
      _$StandingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StandingsResponseToJson(this);
}
