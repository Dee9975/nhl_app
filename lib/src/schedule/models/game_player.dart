import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "game_player.freezed.dart";
part "game_player.g.dart";

/// A player credited in a finished game, e.g. the winning goal scorer.
@freezed
@JsonSerializable()
class const GamePlayer({
  final int playerId = 0,

  /// e.g. `B.`
  final LocalizedName firstInitial = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
}) with _$GamePlayer {
  factory fromJson(Map<String, dynamic> json) => _$GamePlayerFromJson(json);

  Map<String, dynamic> toJson() => _$GamePlayerToJson(this);
}
