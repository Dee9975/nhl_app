import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_officials.freezed.dart";
part "game_officials.g.dart";

/// Officials and coaches, from `gameInfo`. Officials are often empty
/// before the game.
@freezed
@JsonSerializable()
class const GameOfficials({
  final IList<GameOfficial> referees = const IListConst([]),
  final IList<GameOfficial> linesmen = const IListConst([]),
  final TeamGameInfo awayTeam = const TeamGameInfo(),
  final TeamGameInfo homeTeam = const TeamGameInfo(),
}) with _$GameOfficials {
  factory fromJson(Map<String, dynamic> json) => _$GameOfficialsFromJson(json);

  Map<String, dynamic> toJson() => _$GameOfficialsToJson(this);
}
