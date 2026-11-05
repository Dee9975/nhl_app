import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

class const GameCenterRepository(final GameCenterApi _api) {
  /// Landing data for the game with id [gameId].
  Future<Result<GameLanding>> getLanding(int gameId) {
    return Result.guard(_api.getLanding(gameId));
  }

  /// Right-rail data for the game with id [gameId].
  Future<Result<GameRightRail>> getRightRail(int gameId) {
    return Result.guard(_api.getRightRail(gameId));
  }
}
