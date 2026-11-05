import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/leaders/leaders.dart";

void main() {
  group("SkaterLeaderCategory.format", () {
    test("shows counts as whole numbers", () {
      expect(SkaterLeaderCategory.goals.format(52), "52");
      expect(SkaterLeaderCategory.penaltyMins.format(104), "104");
    });

    test("signs plus/minus", () {
      expect(SkaterLeaderCategory.plusMinus.format(23), "+23");
      expect(SkaterLeaderCategory.plusMinus.format(0), "0");
      expect(SkaterLeaderCategory.plusMinus.format(-5), "-5");
    });

    test("shows faceoffs as a percentage", () {
      expect(SkaterLeaderCategory.faceoffLeaders.format(0.636364), "63.6%");
    });

    test("shows time on ice as minutes", () {
      expect(SkaterLeaderCategory.toi.format(1710.4), "28:30");
    });
  });

  group("GoalieLeaderCategory.format", () {
    test("shows save percentage the hockey way", () {
      expect(GoalieLeaderCategory.savePctg.format(0.945055), ".945");
    });

    test("shows goals against average with two decimals", () {
      expect(GoalieLeaderCategory.goalsAgainstAverage.format(1.333136), "1.33");
    });

    test("shows wins and shutouts as whole numbers", () {
      expect(GoalieLeaderCategory.wins.format(40), "40");
      expect(GoalieLeaderCategory.shutouts.format(7), "7");
    });
  });
}
