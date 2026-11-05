import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

void main() {
  group("PlayerLanding.born", () {
    test("joins date and place", () {
      final PlayerLanding player = PlayerLanding(
        birthDate: DateTime(1997, 1, 3),
        birthCity: const LocalizedName(value: "Richmond Hill"),
        birthStateProvince: const LocalizedName(value: "Ontario"),
        birthCountry: "CAN",
      );

      expect(player.born, "1997-01-03 · Richmond Hill, Ontario, CAN");
    });

    test("leaves out a missing state or province", () {
      final PlayerLanding player = PlayerLanding(
        birthDate: DateTime(1996, 9, 23),
        birthCity: const LocalizedName(value: "Stockholm"),
        birthCountry: "SWE",
      );

      expect(player.born, "1996-09-23 · Stockholm, SWE");
    });

    test("shows only the place without a date", () {
      const PlayerLanding player = PlayerLanding(birthCountry: "USA");

      expect(player.born, "USA");
    });

    test("is empty when nothing is known", () {
      expect(const PlayerLanding().born, "");
    });
  });

  group("DraftDetails.label", () {
    test("describes the pick", () {
      const DraftDetails draft = DraftDetails(
        year: 2015,
        teamAbbrev: "EDM",
        round: 1,
        overallPick: 1,
      );

      expect(draft.label, "2015 EDM, round 1, #1 overall");
    });

    test("says Undrafted without a draft year", () {
      expect(const DraftDetails().label, "Undrafted");
    });
  });
}
