import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "game_official.freezed.dart";
part "game_official.g.dart";

/// A referee or linesman.
@freezed
@JsonSerializable()
class const GameOfficial({
  final LocalizedName fullName = const LocalizedName(),
  final int sweaterNumber = 0,
}) with _$GameOfficial {
  factory fromJson(Map<String, dynamic> json) => _$GameOfficialFromJson(json);

  Map<String, dynamic> toJson() => _$GameOfficialToJson(this);
}
