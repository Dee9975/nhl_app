import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

class const PlayersRepository(final PlayersApi _api) {
  /// Bio, stats and recent games for the player with id [playerId].
  Future<Result<PlayerLanding>> getPlayer(int playerId) {
    return Result.guard(_api.getPlayerLanding(playerId));
  }
}
