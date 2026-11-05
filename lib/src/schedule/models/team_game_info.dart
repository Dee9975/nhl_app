import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "team_game_info.freezed.dart";
part "team_game_info.g.dart";

@freezed
@JsonSerializable()
class const TeamGameInfo({
  final LocalizedName headCoach = const LocalizedName(),
  final IList<LocalizedName> scratches = const IListConst([]),
}) with _$TeamGameInfo {
  factory fromJson(Map<String, dynamic> json) => _$TeamGameInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TeamGameInfoToJson(this);
}
