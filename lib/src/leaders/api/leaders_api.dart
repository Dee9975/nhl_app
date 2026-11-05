import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

import "package:nhl_app/src/leaders/leaders.dart";

part "leaders_api.g.dart";

@RestApi()
abstract class LeadersApi {
  factory LeadersApi(Dio dio, {String? baseUrl}) = _LeadersApi;

  /// Current season's skater leaders.
  ///
  /// [categories] is a comma-separated list of [SkaterLeaderCategory] names,
  /// e.g. `goals,assists`; null returns every category. [limit] is the number
  /// of players per category, -1 for all; null uses the API default of 5.
  @GET("/skater-stats-leaders/current")
  Future<SkaterLeadersResponse> getCurrentSkaterLeaders({
    @Query("categories") String? categories,
    @Query("limit") int? limit,
  });

  /// Current season's goalie leaders.
  ///
  /// [categories] is a comma-separated list of [GoalieLeaderCategory] names,
  /// e.g. `wins,shutouts`; null returns every category. [limit] is the number
  /// of players per category, -1 for all; null uses the API default of 5.
  @GET("/goalie-stats-leaders/current")
  Future<GoalieLeadersResponse> getCurrentGoalieLeaders({
    @Query("categories") String? categories,
    @Query("limit") int? limit,
  });
}
