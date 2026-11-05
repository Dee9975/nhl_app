import "package:fake_async/fake_async.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

import "../../../helpers/fakes.dart";

ScheduleResponse _week(List<GameState> states) {
  return ScheduleResponse(
    gameWeek: IList([
      GameDay(
        games: states.map((state) => ScheduleGame(gameState: state)).toIList(),
      ),
    ]),
  );
}

void main() {
  /// Loads the schedule, then lets [elapsed] pass on a fake clock and
  /// returns how many times it was fetched.
  int fetchesAfter(ScheduleResponse schedule, Duration elapsed) {
    final FakeScheduleRepository repository = FakeScheduleRepository(
      schedule: Ok(schedule),
    );

    fakeAsync((async) {
      final ProviderContainer container = ProviderContainer.test(
        overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
        retry: noRetry,
      );
      container.listen(scheduleProvider, (_, _) {});
      async.flushMicrotasks();
      async.elapse(elapsed);
      container.dispose();
    });

    return repository.calls;
  }

  test("refetches while a game is about to start or live", () {
    for (final GameState state in [
      GameState.preGame,
      GameState.live,
      GameState.critical,
    ]) {
      expect(
        fetchesAfter(
          _week([GameState.official, state]),
          liveRefreshInterval * 2.5,
        ),
        3,
        reason: "$state",
      );
    }
  });

  test("does not refetch when no game is ongoing", () {
    expect(
      fetchesAfter(
        _week([GameState.future, GameState.finished, GameState.official]),
        liveRefreshInterval * 3,
      ),
      1,
    );
  });

  test("does not refetch before the interval has passed", () {
    expect(
      fetchesAfter(
        _week([GameState.live]),
        liveRefreshInterval - const Duration(seconds: 1),
      ),
      1,
    );
  });

  test("a failed fetch surfaces the failure", () async {
    final ProviderContainer container = ProviderContainer.test(
      overrides: [
        scheduleRepositoryProvider.overrideWithValue(
          FakeScheduleRepository(schedule: const Err(Offline())),
        ),
      ],
      retry: noRetry,
    );
    container.listen(scheduleProvider, (_, _) {});

    await expectLater(
      container.read(scheduleProvider.future),
      throwsA(isA<Offline>()),
    );
  });
}
