import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "game_center_api.g.dart";

@RestApi()
abstract class GameCenterApi {
  factory GameCenterApi(Dio dio, {String? baseUrl}) = _GameCenterApi;

  /// Teams, clock, scoring summary and three stars, or the pre-game
  /// matchup, for the game with id [gameId].
  @GET("/gamecenter/{gameId}/landing")
  Future<GameLanding> getLanding(@Path() int gameId);

  /// Linescore, team stats, season series and officials, or season stats
  /// and recent form before the game, for the game with id [gameId].
  @GET("/gamecenter/{gameId}/right-rail")
  Future<GameRightRail> getRightRail(@Path() int gameId);
}
