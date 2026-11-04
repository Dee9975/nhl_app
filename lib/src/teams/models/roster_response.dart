import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/teams/teams.dart";

part "roster_response.freezed.dart";
part "roster_response.g.dart";

@freezed
@JsonSerializable()
class const RosterResponse({
  final IList<RosterPlayer> forwards = const IListConst([]),
  final IList<RosterPlayer> defensemen = const IListConst([]),
  final IList<RosterPlayer> goalies = const IListConst([]),
}) with _$RosterResponse {
  factory fromJson(Map<String, dynamic> json) => _$RosterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RosterResponseToJson(this);
}
