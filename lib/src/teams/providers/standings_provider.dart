import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/teams/teams.dart";

part "standings_provider.g.dart";

/// [teamsProvider] grouped and ranked for the selected
/// [standingsViewSelectionProvider]:
/// - division: one group per division, in conference then division order,
///   ranked within the division;
/// - league: one group with every team, ranked league-wide.
///
/// Switching views regroups the cached standings without refetching.
/// Returns the view with its groups, so a list still shown while the next
/// view is grouped keeps the view it belongs to.
@riverpod
Future<Standings> standings(Ref ref) async {
  final IList<TeamStanding> teams = await ref.watch(teamsProvider.future);
  final StandingsView view = ref.watch(standingsViewSelectionProvider);

  switch (view) {
    case .league:
      // Teams arrive already in league rank order.
      return (
        view: view,
        groups: IList([
          (
            name: "League",
            teams: teams
                .map((team) => (rank: team.leagueSequence, standing: team))
                .toIList(),
          ),
        ]),
      );

    case .division:
      // Teams come pre sorted by rank from the api already
      final IList<TeamStanding> ordered = teams.sortOrdered((a, b) {
        final int byConference = a.conferenceName.compareTo(b.conferenceName);
        if (byConference != 0) return byConference;
        return a.divisionName.compareTo(b.divisionName);
      });
      // Insertion order keeps the conference, division order from above.
      final Map<String, List<RankedTeam>> divisions = {};
      for (final TeamStanding team in ordered) {
        divisions.putIfAbsent(team.divisionName, () => []).add((
          rank: team.divisionSequence,
          standing: team,
        ));
      }
      return (
        view: view,
        groups: divisions.entries
            .map((entry) => (name: entry.key, teams: entry.value.toIList()))
            .toIList(),
      );
  }
}
