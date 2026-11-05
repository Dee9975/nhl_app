import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/leaders/leaders.dart";

part "leaders_category_provider.g.dart";

/// The leaderboard category the user picked. Starts on skater goals.
///
/// Remembers the last pick in each [LeaderGroup], so switching back to a
/// group returns to the category the user left it on.
@riverpod
class LeadersCategory extends _$LeadersCategory {
  SkaterLeaderCategory _skater = .goals;
  GoalieLeaderCategory _goalie = .wins;

  @override
  LeaderCategory build() => _skater;

  void select(LeaderCategory category) {
    switch (category) {
      case SkaterLeaderCategory():
        _skater = category;
      case GoalieLeaderCategory():
        _goalie = category;
    }
    state = category;
  }

  /// Switches to [group], on the category last picked there.
  void selectGroup(LeaderGroup group) {
    state = switch (group) {
      .skaters => _skater,
      .goalies => _goalie,
    };
  }
}
