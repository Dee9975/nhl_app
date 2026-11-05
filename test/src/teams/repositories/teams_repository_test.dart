import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Records the date each standings call was made with.
class _RecordingTeamsApi implements TeamsApi {
  String? date;
  bool fail = false;

  @override
  Future<StandingsResponse> getStandings(String date) async {
    this.date = date;
    if (fail) {
      throw const FormatException("bad payload");
    }
    return StandingsResponse(standings: IList(const [TeamStanding()]));
  }

  @override
  Future<RosterResponse> getRoster(String teamAbbrev) {
    throw UnimplementedError();
  }
}

void main() {
  late _RecordingTeamsApi api;
  late TeamsRepository repository;

  setUp(() {
    api = _RecordingTeamsApi();
    repository = TeamsRepository(api);
  });

  test("asks for today when no date is given", () async {
    await repository.getStandings();

    expect(api.date, TeamsApi.today);
  });

  test("asks for the given date", () async {
    await repository.getStandings(DateTime(2026, 3, 7));

    expect(api.date, "2026-03-07");
  });

  test("unwraps the standings list", () async {
    expect(await repository.getStandings(), Ok(IList(const [TeamStanding()])));
  });

  test("returns an API failure as Err", () async {
    api.fail = true;

    expect(await repository.getStandings(), isA<Err<IList<TeamStanding>>>());
  });
}
