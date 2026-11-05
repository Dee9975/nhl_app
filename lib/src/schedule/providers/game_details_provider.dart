import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "game_details_provider.g.dart";

/// Landing and right-rail data for the game with id [gameId], fetched in
/// parallel. Refetches every [liveRefreshInterval] while the game is about
/// to start or in progress.
@riverpod
Future<GameDetails> gameDetails(Ref ref, int gameId) async {
  final repo = ref.watch(gameCenterRepositoryProvider);

  final (Result<GameLanding> landing, Result<GameRightRail> rightRail) = await (
    repo.getLanding(gameId),
    repo.getRightRail(gameId),
  ).wait;

  final GameDetails details = (
    landing: switch (landing) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    },
    rightRail: switch (rightRail) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    },
  );

  if (details.landing.gameState.isOngoing) {
    final Timer timer = Timer(liveRefreshInterval, ref.invalidateSelf);
    ref.onDispose(timer.cancel);
  }

  return details;
}
