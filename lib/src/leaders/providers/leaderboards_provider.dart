import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

part "leaderboards_provider.g.dart";

/// Number of players fetched per leaderboard.
const int leaderboardLimit = 15;

/// Every skater leaderboard in one request, kept so switching categories
/// doesn't refetch.
@Riverpod(keepAlive: true)
Future<SkaterLeadersResponse> skaterLeaders(Ref ref) async {
  final repo = ref.watch(leadersRepositoryProvider);

  final Result<SkaterLeadersResponse> result = await repo
      .getCurrentSkaterLeaders(limit: leaderboardLimit);
  return switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}

/// Every goalie leaderboard in one request, kept so switching categories
/// doesn't refetch.
@Riverpod(keepAlive: true)
Future<GoalieLeadersResponse> goalieLeaders(Ref ref) async {
  final repo = ref.watch(leadersRepositoryProvider);

  final Result<GoalieLeadersResponse> result = await repo
      .getCurrentGoalieLeaders(limit: leaderboardLimit);
  return switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}
