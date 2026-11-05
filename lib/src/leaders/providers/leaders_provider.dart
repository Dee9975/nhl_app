import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/leaders/leaders.dart";

part "leaders_provider.g.dart";

/// The leaderboard for the selected [leadersCategoryProvider], picked from
/// the cached [skaterLeadersProvider] or [goalieLeadersProvider]. Each group
/// is fetched once; switching categories doesn't refetch.
///
/// Returns the category with its leaders, so a list still shown while the
/// next one loads keeps the category it belongs to.
@riverpod
Future<Leaderboard> leaders(Ref ref) async {
  final LeaderCategory category = ref.watch(leadersCategoryProvider);

  return (
    category: category,
    leaders: switch (category) {
      SkaterLeaderCategory() => (await ref.watch(
        skaterLeadersProvider.future,
      ))[category],
      GoalieLeaderCategory() => (await ref.watch(
        goalieLeadersProvider.future,
      ))[category],
    },
  );
}
