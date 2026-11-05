import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/leaders/leaders.dart";

void main() {
  late ProviderContainer container;
  late LeadersCategory notifier;

  LeaderCategory current() => container.read(leadersCategoryProvider);

  setUp(() {
    container = ProviderContainer.test();
    container.listen(leadersCategoryProvider, (_, _) {});
    notifier = container.read(leadersCategoryProvider.notifier);
  });

  test("starts on skater goals", () {
    expect(current(), SkaterLeaderCategory.goals);
  });

  test("opens goalies on wins before anything was picked there", () {
    notifier.selectGroup(LeaderGroup.goalies);

    expect(current(), GoalieLeaderCategory.wins);
  });

  test("returns to the last goalie pick after visiting skaters", () {
    notifier
      ..selectGroup(LeaderGroup.goalies)
      ..select(GoalieLeaderCategory.savePctg)
      ..selectGroup(LeaderGroup.skaters)
      ..selectGroup(LeaderGroup.goalies);

    expect(current(), GoalieLeaderCategory.savePctg);
  });

  test("returns to the last skater pick after visiting goalies", () {
    notifier
      ..select(SkaterLeaderCategory.points)
      ..selectGroup(LeaderGroup.goalies)
      ..selectGroup(LeaderGroup.skaters);

    expect(current(), SkaterLeaderCategory.points);
  });
}
