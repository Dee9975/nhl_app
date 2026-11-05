import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

class const LeadersRepository(final LeadersApi _api) {
  /// Current season's skater leaders in [categories], or in every category
  /// when [categories] is empty.
  ///
  /// [limit] is the number of players per category, -1 for all; null uses
  /// the API default of 5.
  Future<Result<SkaterLeadersResponse>> getCurrentSkaterLeaders({
    Iterable<SkaterLeaderCategory> categories = const [],
    int? limit,
  }) {
    final String? query = switch (categories) {
      Iterable(isEmpty: true) => null,
      _ => categories.map((category) => category.name).join(","),
    };

    return Result.guard(
      _api.getCurrentSkaterLeaders(categories: query, limit: limit),
    );
  }

  /// Current season's goalie leaders in [categories], or in every category
  /// when [categories] is empty.
  ///
  /// [limit] is the number of players per category, -1 for all; null uses
  /// the API default of 5.
  Future<Result<GoalieLeadersResponse>> getCurrentGoalieLeaders({
    Iterable<GoalieLeaderCategory> categories = const [],
    int? limit,
  }) {
    final String? query = switch (categories) {
      Iterable(isEmpty: true) => null,
      _ => categories.map((category) => category.name).join(","),
    };

    return Result.guard(
      _api.getCurrentGoalieLeaders(categories: query, limit: limit),
    );
  }
}
