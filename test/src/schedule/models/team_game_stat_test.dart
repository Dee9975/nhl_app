import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/schedule/schedule.dart";

void main() {
  group("awayShare", () {
    test("is the away team's part of the total", () {
      const TeamGameStat stat = TeamGameStat(
        category: "sog",
        awayValue: 30,
        homeValue: 10,
      );

      expect(stat.awayShare, 0.75);
    });

    test("is null when both teams are at zero", () {
      const TeamGameStat stat = TeamGameStat(
        category: "hits",
        awayValue: 0,
        homeValue: 0,
      );

      expect(stat.awayShare, isNull);
    });

    test("is null for text values", () {
      const TeamGameStat stat = TeamGameStat(
        category: "powerPlay",
        awayValue: "1/3",
        homeValue: "0/2",
      );

      expect(stat.awayShare, isNull);
    });

    test("handles an int next to a double", () {
      const TeamGameStat stat = TeamGameStat(
        category: "powerPlayPctg",
        awayValue: 0,
        homeValue: 0.5,
      );

      expect(stat.awayShare, 0);
    });
  });

  group("value text", () {
    test("shows Pctg categories as percentages, ints included", () {
      const TeamGameStat stat = TeamGameStat(
        category: "faceoffWinningPctg",
        awayValue: 0.614,
        homeValue: 1,
      );

      expect(stat.awayText, "61.4%");
      expect(stat.homeText, "100.0%");
    });

    test("shows other values as given", () {
      const TeamGameStat stat = TeamGameStat(
        category: "powerPlay",
        awayValue: "1/3",
        homeValue: 12,
      );

      expect(stat.awayText, "1/3");
      expect(stat.homeText, "12");
    });

    test("shows a missing value as a dash", () {
      const TeamGameStat stat = TeamGameStat(category: "sog", awayValue: 3);

      expect(stat.homeText, "–");
    });
  });

  test("label names known categories and passes others through", () {
    expect(const TeamGameStat(category: "sog").label, "Shots");
    expect(const TeamGameStat(category: "newStat").label, "newStat");
  });
}
