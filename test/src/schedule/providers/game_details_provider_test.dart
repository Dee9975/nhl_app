import "package:fake_async/fake_async.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

import "../../../helpers/fakes.dart";

const int _gameId = 2025020001;

void main() {
  ProviderContainer containerFor(FakeGameCenterRepository repository) {
    return ProviderContainer.test(
      overrides: [gameCenterRepositoryProvider.overrideWithValue(repository)],
      retry: noRetry,
    );
  }

  Future<GameDetails> read(ProviderContainer container) {
    container.listen(gameDetailsProvider(_gameId), (_, _) {});
    return container.read(gameDetailsProvider(_gameId).future);
  }

  test("combines landing and right rail", () async {
    const GameLanding landing = GameLanding(id: _gameId);
    const GameRightRail rightRail = GameRightRail();
    final ProviderContainer container = containerFor(
      FakeGameCenterRepository(
        landing: const Ok(landing),
        rightRail: const Ok(rightRail),
      ),
    );

    final GameDetails details = await read(container);

    expect(details.landing, landing);
    expect(details.rightRail, rightRail);
  });

  test("fails when the landing fails", () async {
    final ProviderContainer container = containerFor(
      FakeGameCenterRepository(landing: const Err(NotFound())),
    );

    await expectLater(read(container), throwsA(isA<NotFound>()));
  });

  test("fails when the right rail fails", () async {
    final ProviderContainer container = containerFor(
      FakeGameCenterRepository(rightRail: const Err(Offline())),
    );

    await expectLater(read(container), throwsA(isA<Offline>()));
  });

  /// Loads a game in [state], lets 2.5 refresh intervals pass on a fake
  /// clock and returns how many times it was fetched.
  int fetchesFor(GameState state) {
    final FakeGameCenterRepository repository = FakeGameCenterRepository(
      landing: Ok(GameLanding(gameState: state)),
    );

    fakeAsync((async) {
      final ProviderContainer container = containerFor(repository);
      container.listen(gameDetailsProvider(_gameId), (_, _) {});
      async.flushMicrotasks();
      async.elapse(liveRefreshInterval * 2.5);
      container.dispose();
    });

    return repository.landingCalls;
  }

  test("refetches while the game is live", () {
    expect(fetchesFor(GameState.live), 3);
  });

  test("does not refetch a finished game", () {
    expect(fetchesFor(GameState.official), 1);
  });
}
