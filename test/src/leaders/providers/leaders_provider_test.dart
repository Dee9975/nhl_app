import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

import "../../../helpers/fakes.dart";

IList<StatLeader> _board(int id) => IList([StatLeader(id: id)]);

void main() {
  late FakeLeadersRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeLeadersRepository(
      skaters: Ok(SkaterLeadersResponse(goals: _board(1), points: _board(2))),
      goalies: Ok(GoalieLeadersResponse(wins: _board(3))),
    );
    container = ProviderContainer.test(
      overrides: [leadersRepositoryProvider.overrideWithValue(repository)],
      retry: noRetry,
    );
  });

  Future<Leaderboard> read() {
    container.listen(leadersProvider, (_, _) {});
    return container.read(leadersProvider.future);
  }

  LeadersCategory category() {
    return container.read(leadersCategoryProvider.notifier);
  }

  test("returns the selected category with its leaders", () async {
    final Leaderboard board = await read();

    expect(board.category, SkaterLeaderCategory.goals);
    expect(board.leaders, _board(1));
  });

  test("switching skater categories fetches skaters once", () async {
    await read();
    category().select(SkaterLeaderCategory.points);
    final Leaderboard board = await read();

    expect(board.leaders, _board(2));
    expect(repository.skaterCalls, 1);
    expect(repository.goalieCalls, 0);
  });

  test("switching to goalies fetches goalies, not skaters again", () async {
    await read();
    category().selectGroup(LeaderGroup.goalies);
    final Leaderboard board = await read();

    expect(board.category, GoalieLeaderCategory.wins);
    expect(board.leaders, _board(3));
    expect(repository.skaterCalls, 1);
    expect(repository.goalieCalls, 1);
  });

  test("a failed fetch surfaces the failure", () async {
    repository.skaters = const Err(Offline());

    await expectLater(read(), throwsA(isA<Offline>()));
  });
}
