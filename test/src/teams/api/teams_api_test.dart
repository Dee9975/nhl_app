import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/teams/teams.dart";

void main() {
  test("formatDate pads month and day to yyyy-MM-dd", () {
    expect(TeamsApi.formatDate(DateTime(2026, 3, 7)), "2026-03-07");
    expect(TeamsApi.formatDate(DateTime(2026, 11, 25)), "2026-11-25");
  });
}
