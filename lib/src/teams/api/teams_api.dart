import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

import "package:nhl_app/src/teams/teams.dart";

part "teams_api.g.dart";

@RestApi()
abstract class TeamsApi {
  factory TeamsApi(Dio dio, {String? baseUrl}) = _TeamsApi;

  /// Formats [date] as `yyyy-MM-dd`, the path format `/standings` expects.
  static String formatDate(DateTime date) {
    final String month = date.month.toString().padLeft(2, "0");
    final String day = date.day.toString().padLeft(2, "0");
    return "${date.year}-$month-$day";
  }

  /// Today's date (`DateTime.now()`) as `yyyy-MM-dd`.
  static String get today => formatDate(DateTime.now());

  /// Standings for every team on [date] (`yyyy-MM-dd`).
  ///
  /// Pass [today] for current standings, or [formatDate] for another day.
  @GET("/standings/{date}")
  Future<StandingsResponse> getStandings(@Path() String date);

  /// Current roster for the team with abbreviation [teamAbbrev] (e.g. `TOR`).
  @GET("/roster/{teamAbbrev}/current")
  Future<RosterResponse> getRoster(@Path() String teamAbbrev);
}
