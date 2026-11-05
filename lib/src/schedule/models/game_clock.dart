import "package:freezed_annotation/freezed_annotation.dart";

part "game_clock.freezed.dart";
part "game_clock.g.dart";

/// Game clock of the current period.
@freezed
@JsonSerializable()
class const GameClock({
  final String timeRemaining = "",
  final int secondsRemaining = 0,
  final bool running = false,
  final bool inIntermission = false,
}) with _$GameClock {
  factory fromJson(Map<String, dynamic> json) => _$GameClockFromJson(json);

  Map<String, dynamic> toJson() => _$GameClockToJson(this);
}
