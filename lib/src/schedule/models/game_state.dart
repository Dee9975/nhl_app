import "package:freezed_annotation/freezed_annotation.dart";

/// How often live data refetches while a game is about to start or in
/// progress.
const Duration liveRefreshInterval = Duration(seconds: 60);

/// Where a game is in its lifecycle, from `gameState`.
enum GameState {
  /// Scheduled, not started.
  @JsonValue("FUT")
  future,

  /// Warm-ups, shortly before puck drop.
  @JsonValue("PRE")
  preGame,
  @JsonValue("LIVE")
  live,

  /// Live and in the final minutes or overtime.
  @JsonValue("CRIT")
  critical,

  /// Ended, stats not yet official.
  @JsonValue("FINAL")
  finished,

  /// Ended and official.
  @JsonValue("OFF")
  official,
  unknown;

  /// About to start or in progress, so its data changes by the minute.
  bool get isOngoing => switch (this) {
    preGame || live || critical => true,
    future || finished || official || unknown => false,
  };
}
