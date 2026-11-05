import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

part "player_provider.g.dart";

/// Bio, stats and recent games for the player with id [playerId].
@riverpod
Future<PlayerLanding> player(Ref ref, int playerId) async {
  final repo = ref.watch(playersRepositoryProvider);

  final Result<PlayerLanding> result = await repo.getPlayer(playerId);
  return switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}
