import "package:nhl_app/src/core/core.dart";

/// A leaderboard stat category, either a [SkaterLeaderCategory] or a
/// [GoalieLeaderCategory]. Switches over it are exhaustive across both.
sealed class LeaderCategory {
  /// A leader's value in this category's unit, e.g. `15`, `+23`, `63.6%`,
  /// `28:30`, `.945` or `1.33`.
  String format(double value);
}

/// Which leaderboards are shown: skaters or goalies.
enum LeaderGroup { skaters, goalies }

/// Stat categories of `GET /skater-stats-leaders/current`.
///
/// Each [name] is the API's value for the `categories` query parameter and
/// the matching key in the response.
enum SkaterLeaderCategory implements LeaderCategory {
  goals,
  assists,
  points,
  plusMinus,

  /// Power play goals.
  goalsPp,

  /// Shorthanded goals.
  goalsSh,
  penaltyMins,

  /// Faceoff win percentage as a fraction, e.g. `0.636364`.
  faceoffLeaders,

  /// Average time on ice per game, in seconds.
  toi;

  @override
  String format(double value) {
    return switch (this) {
      faceoffLeaders => StatFormat.percent(value),
      toi => StatFormat.minutes(value.round()),
      plusMinus => StatFormat.signed(value.round()),
      goals ||
      assists ||
      points ||
      goalsPp ||
      goalsSh ||
      penaltyMins => "${value.round()}",
    };
  }
}

/// Stat categories of `GET /goalie-stats-leaders/current`.
///
/// Each [name] is the API's value for the `categories` query parameter and
/// the matching key in the response. Any other name returns 400.
enum GoalieLeaderCategory implements LeaderCategory {
  wins,
  shutouts,

  /// Save percentage as a fraction, e.g. `0.945055`.
  savePctg,

  /// Goals against per 60 minutes, e.g. `1.333136`. Lower is better.
  goalsAgainstAverage;

  @override
  String format(double value) {
    return switch (this) {
      savePctg => StatFormat.savePct(value),
      goalsAgainstAverage => value.toStringAsFixed(2),
      wins || shutouts => "${value.round()}",
    };
  }
}
