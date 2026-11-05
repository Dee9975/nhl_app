import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

import "package:nhl_app/src/players/players.dart";

part "players_api.g.dart";

@RestApi()
abstract class PlayersApi {
  factory PlayersApi(Dio dio, {String? baseUrl}) = _PlayersApi;

  /// Bio, stats and recent games for the player with id [playerId].
  @GET("/player/{playerId}/landing")
  Future<PlayerLanding> getPlayerLanding(@Path() int playerId);
}
