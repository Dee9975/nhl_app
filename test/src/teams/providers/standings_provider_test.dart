import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

import "../../../helpers/fakes.dart";

TeamStanding _team(
  String abbrev, {
  required String conference,
  required String division,
  required int divisionRank,
  required int leagueRank,
}) {
  return TeamStanding(
    teamAbbrev: LocalizedName(value: abbrev),
    conferenceName: conference,
    divisionName: division,
    divisionSequence: divisionRank,
    leagueSequence: leagueRank,
  );
}

/// Two teams per division, in league rank order as the API sends them.
final IList<TeamStanding> _leagueOrder = IList([
  _team(
    "WPG",
    conference: "Western",
    division: "Central",
    divisionRank: 1,
    leagueRank: 1,
  ),
  _team(
    "WSH",
    conference: "Eastern",
    division: "Metropolitan",
    divisionRank: 1,
    leagueRank: 2,
  ),
  _team(
    "TOR",
    conference: "Eastern",
    division: "Atlantic",
    divisionRank: 1,
    leagueRank: 3,
  ),
  _team(
    "VGK",
    conference: "Western",
    division: "Pacific",
    divisionRank: 1,
    leagueRank: 4,
  ),
  _team(
    "DAL",
    conference: "Western",
    division: "Central",
    divisionRank: 2,
    leagueRank: 5,
  ),
  _team(
    "TBL",
    conference: "Eastern",
    division: "Atlantic",
    divisionRank: 2,
    leagueRank: 6,
  ),
  _team(
    "CAR",
    conference: "Eastern",
    division: "Metropolitan",
    divisionRank: 2,
    leagueRank: 7,
  ),
  _team(
    "LAK",
    conference: "Western",
    division: "Pacific",
    divisionRank: 2,
    leagueRank: 8,
  ),
]);

List<String> _abbrevs(StandingsGroup group) {
  return group.teams.map((team) => team.standing.teamAbbrev.value).toList();
}

List<int> _ranks(StandingsGroup group) {
  return group.teams.map((team) => team.rank).toList();
}

void main() {
  late FakeTeamsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeTeamsRepository(standings: Ok(_leagueOrder));
    container = ProviderContainer.test(
      overrides: [teamsRepositoryProvider.overrideWithValue(repository)],
      retry: noRetry,
    );
  });

  /// Keeps the provider alive across reads, like a screen watching it.
  Future<Standings> read() {
    container.listen(standingsProvider, (_, _) {});
    return container.read(standingsProvider.future);
  }

  test("groups by division, conference then division order", () async {
    final Standings standings = await read();

    expect(standings.view, StandingsView.division);
    expect(standings.groups.map((group) => group.name).toList(), [
      "Atlantic",
      "Metropolitan",
      "Central",
      "Pacific",
    ]);
  });

  // Relies on the API sending teams in league order: the provider keeps
  // that order inside each division instead of sorting by divisionSequence.
  test("keeps each division in rank order", () async {
    final Standings standings = await read();

    expect(_abbrevs(standings.groups[0]), ["TOR", "TBL"]);
    expect(_abbrevs(standings.groups[1]), ["WSH", "CAR"]);
    expect(_abbrevs(standings.groups[2]), ["WPG", "DAL"]);
    expect(_abbrevs(standings.groups[3]), ["VGK", "LAK"]);
    for (final StandingsGroup group in standings.groups) {
      expect(_ranks(group), [1, 2], reason: group.name);
    }
  });

  test("league view keeps API order and ranks by leagueSequence", () async {
    container
        .read(standingsViewSelectionProvider.notifier)
        .select(StandingsView.league);

    final Standings standings = await read();

    expect(standings.view, StandingsView.league);
    expect(standings.groups, hasLength(1));
    expect(standings.groups.single.name, "League");
    expect(
      _abbrevs(standings.groups.single),
      _leagueOrder.map((team) => team.teamAbbrev.value).toList(),
    );
    expect(_ranks(standings.groups.single), [1, 2, 3, 4, 5, 6, 7, 8]);
  });

  test("switching views regroups without refetching", () async {
    await read();
    container
        .read(standingsViewSelectionProvider.notifier)
        .select(StandingsView.league);
    await read();

    expect(repository.standingsCalls, 1);
  });

  test("a failed fetch surfaces the failure", () async {
    repository.standings = const Err(Offline());

    await expectLater(read(), throwsA(isA<Offline>()));
  });
}
