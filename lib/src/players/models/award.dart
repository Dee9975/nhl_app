import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

part "award.freezed.dart";
part "award.g.dart";

@freezed
@JsonSerializable()
class const Award({
  final LocalizedName trophy = const LocalizedName(),
  final IList<AwardSeason> seasons = const IListConst([]),
}) with _$Award {
  factory fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);

  Map<String, dynamic> toJson() => _$AwardToJson(this);
}
