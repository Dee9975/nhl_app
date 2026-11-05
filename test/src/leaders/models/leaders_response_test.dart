import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/leaders/leaders.dart";

/// A board whose single leader's id identifies which field it came from.
IList<StatLeader> _board(int id) => IList([StatLeader(id: id)]);

void main() {
  test("each skater category reads its own leaderboard", () {
    final SkaterLeadersResponse response = SkaterLeadersResponse(
      goals: _board(0),
      assists: _board(1),
      points: _board(2),
      plusMinus: _board(3),
      goalsPp: _board(4),
      goalsSh: _board(5),
      penaltyMins: _board(6),
      faceoffLeaders: _board(7),
      toi: _board(8),
    );
    const Map<SkaterLeaderCategory, int> ids = {
      SkaterLeaderCategory.goals: 0,
      SkaterLeaderCategory.assists: 1,
      SkaterLeaderCategory.points: 2,
      SkaterLeaderCategory.plusMinus: 3,
      SkaterLeaderCategory.goalsPp: 4,
      SkaterLeaderCategory.goalsSh: 5,
      SkaterLeaderCategory.penaltyMins: 6,
      SkaterLeaderCategory.faceoffLeaders: 7,
      SkaterLeaderCategory.toi: 8,
    };

    expect(ids.keys, unorderedEquals(SkaterLeaderCategory.values));
    for (final SkaterLeaderCategory category in SkaterLeaderCategory.values) {
      expect(response[category], _board(ids[category]!), reason: "$category");
    }
  });

  test("each goalie category reads its own leaderboard", () {
    final GoalieLeadersResponse response = GoalieLeadersResponse(
      wins: _board(0),
      shutouts: _board(1),
      savePctg: _board(2),
      goalsAgainstAverage: _board(3),
    );
    const Map<GoalieLeaderCategory, int> ids = {
      GoalieLeaderCategory.wins: 0,
      GoalieLeaderCategory.shutouts: 1,
      GoalieLeaderCategory.savePctg: 2,
      GoalieLeaderCategory.goalsAgainstAverage: 3,
    };

    expect(ids.keys, unorderedEquals(GoalieLeaderCategory.values));
    for (final GoalieLeaderCategory category in GoalieLeaderCategory.values) {
      expect(response[category], _board(ids[category]!), reason: "$category");
    }
  });
}
