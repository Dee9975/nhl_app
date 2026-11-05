import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";

void main() {
  group("StatFormat.savePct", () {
    test("drops the leading zero", () {
      expect(StatFormat.savePct(0.923), ".923");
      expect(StatFormat.savePct(0), ".000");
    });

    test("keeps a perfect save percentage whole", () {
      expect(StatFormat.savePct(1), "1.000");
    });

    test("rounds to three places", () {
      expect(StatFormat.savePct(0.91649), ".916");
      expect(StatFormat.savePct(0.9995), "1.000");
    });
  });

  test("percent shows a fraction with one decimal", () {
    expect(StatFormat.percent(0.1516), "15.2%");
    expect(StatFormat.percent(1), "100.0%");
    expect(StatFormat.percent(0), "0.0%");
  });

  test("minutes pads seconds to two digits", () {
    expect(StatFormat.minutes(1710), "28:30");
    expect(StatFormat.minutes(65), "1:05");
    expect(StatFormat.minutes(0), "0:00");
  });

  test("signed adds + only to positive numbers", () {
    expect(StatFormat.signed(23), "+23");
    expect(StatFormat.signed(0), "0");
    expect(StatFormat.signed(-4), "-4");
  });

  test("season shortens the end year", () {
    expect(StatFormat.season(20262027), "2026-27");
    expect(StatFormat.season(19992000), "1999-00");
  });

  test("season leaves an unexpected value as given", () {
    expect(StatFormat.season(0), "0");
    expect(StatFormat.season(2026), "2026");
  });

  test("height shows feet and inches", () {
    expect(StatFormat.height(74), "6'2\"");
    expect(StatFormat.height(72), "6'0\"");
  });

  test("ordinal picks the right suffix, including the teens", () {
    const Map<int, String> expected = {
      1: "1st",
      2: "2nd",
      3: "3rd",
      4: "4th",
      11: "11th",
      12: "12th",
      13: "13th",
      21: "21st",
      22: "22nd",
      23: "23rd",
      101: "101st",
      111: "111th",
    };
    expected.forEach((n, label) => expect(StatFormat.ordinal(n), label));
  });
}
