import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

class const TeamsRepository(final TeamsApi _api) {
  /// Standings for every team on [date], or today when [date] is null.
  Future<Result<IList<TeamStanding>>> getStandings([DateTime? date]) {
    return Result.guard(_fetchStandings(date));
  }

  /// Current roster for the team with abbreviation [abr].
  Future<Result<RosterResponse>> getRoster(String abr) {
    return Result.guard(_api.getRoster(abr));
  }

  Future<IList<TeamStanding>> _fetchStandings(DateTime? date) async {
    final String day = switch (date) {
      null => TeamsApi.today,
      _ => TeamsApi.formatDate(date),
    };

    final response = await _api.getStandings(day);
    return response.standings;
  }
}
