import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/leaders/leaders.dart";
import "package:nhl_app/src/players/players.dart";
import "package:nhl_app/src/schedule/schedule.dart";
import "package:nhl_app/src/teams/teams.dart";

import "../helpers/fixtures.dart";

/// Parses one real response per endpoint, captured in `test/fixtures/`,
/// and spot-checks fields the app relies on. Catches API shape changes and
/// mapping mistakes, not the generated code itself.
///
/// Refresh a fixture by saving the endpoint's response over its file.
void main() {
  test("standings", () {
    final StandingsResponse response = StandingsResponse.fromJson(
      fixture("standings"),
    );

    expect(response.standings, hasLength(32));
    final TeamStanding first = response.standings.first;
    expect(first.teamAbbrev.value, "WPG");
    expect(first.leagueSequence, 1);
    expect(first.conferenceName, "Western");
    expect(first.divisionName, "Central");
    expect(first.streakCode, isNot(StreakCode.unknown));
    expect(
      response.standings.map((team) => team.leagueSequence),
      List.generate(32, (i) => i + 1),
      reason: "the league view relies on the API sending league order",
    );
  });

  test("roster", () {
    final RosterResponse response = RosterResponse.fromJson(fixture("roster"));

    expect(response.forwards, isNotEmpty);
    expect(response.defensemen, isNotEmpty);
    expect(response.goalies, isNotEmpty);
    expect(response.goalies.first.positionCode, "G");
    expect(response.forwards.first.lastName.value, isNotEmpty);
  });

  test("player landing", () {
    final PlayerLanding player = PlayerLanding.fromJson(
      fixture("player_landing"),
    );

    expect(player.firstName.value, "Connor");
    expect(player.heightInInches, 74);
    expect(player.birthDate, isNotNull);
    expect(player.draftDetails.label, "2015 EDM, round 1, #1 overall");
    expect(player.careerTotals.regularSeason.gamesPlayed, greaterThan(0));
    expect(player.featuredStats.season, greaterThan(20000000));
  });

  test("skater leaders", () {
    final SkaterLeadersResponse response = SkaterLeadersResponse.fromJson(
      fixture("skater_leaders"),
    );

    for (final SkaterLeaderCategory category in SkaterLeaderCategory.values) {
      expect(response[category], isNotEmpty, reason: "$category");
    }
    expect(response.goals.first.lastName.value, isNotEmpty);
  });

  test("goalie leaders", () {
    final GoalieLeadersResponse response = GoalieLeadersResponse.fromJson(
      fixture("goalie_leaders"),
    );

    for (final GoalieLeaderCategory category in GoalieLeaderCategory.values) {
      expect(response[category], isNotEmpty, reason: "$category");
    }
    expect(response.savePctg.first.value, inInclusiveRange(0.8, 1));
  });

  test("schedule", () {
    final ScheduleResponse response = ScheduleResponse.fromJson(
      fixture("schedule"),
    );

    expect(response.gameWeek, hasLength(7));
    expect(response.gameWeek.first.date, DateTime(2025, 4, 14));
    final ScheduleGame game = response.gameWeek.first.games.first;
    expect(game.gameState, GameState.official);
    expect(game.startTimeUTC, isNotNull);
    expect(game.homeTeam.abbrev, isNotEmpty);
  });

  test("game landing", () {
    final GameLanding landing = GameLanding.fromJson(fixture("game_landing"));

    expect(landing.id, 2024021300);
    expect(landing.gameState, GameState.official);
    expect(landing.awayTeam.abbrev, "LAK");
    expect(landing.homeTeam.abbrev, "SEA");
    expect(landing.periodDescriptor.label, "3rd");
    expect(landing.summary, isNotNull);
  });

  test("game right rail", () {
    final GameRightRail rightRail = GameRightRail.fromJson(
      fixture("game_right_rail"),
    );

    expect(rightRail.teamGameStats, isNotEmpty);
    expect(
      rightRail.teamGameStats.map((stat) => stat.category),
      contains("sog"),
    );
    expect(rightRail.linescore, isNotNull);
    expect(rightRail.shotsByPeriod, isNotEmpty);
  });

  group("unexpected values", () {
    test("an unknown game state falls back to unknown", () {
      final Map<String, dynamic> json = fixture("game_landing")
        ..["gameState"] = "SOMETHING_NEW";

      expect(GameLanding.fromJson(json).gameState, GameState.unknown);
    });

    test("an unknown streak code falls back to unknown", () {
      final Map<String, dynamic> json = fixture("standings");
      final List<dynamic> standings = json["standings"] as List<dynamic>;
      (standings.first as Map<String, dynamic>)["streakCode"] = "X";

      expect(
        StandingsResponse.fromJson(json).standings.first.streakCode,
        StreakCode.unknown,
      );
    });

    test("missing fields use their defaults", () {
      final StandingsResponse response = StandingsResponse.fromJson({
        "standings": [<String, dynamic>{}],
      });

      expect(response.standings.single, const TeamStanding());
    });
  });
}
