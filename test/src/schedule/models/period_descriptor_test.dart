import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/schedule/schedule.dart";

String _label(int number, String periodType) {
  return PeriodDescriptor(
    number: number,
    periodType: periodType,
    maxRegulationPeriods: 3,
  ).label;
}

void main() {
  test("names regulation periods as ordinals", () {
    expect(_label(1, "REG"), "1st");
    expect(_label(2, "REG"), "2nd");
    expect(_label(3, "REG"), "3rd");
  });

  test("names the first overtime OT", () {
    expect(_label(4, "OT"), "OT");
  });

  test("numbers later playoff overtimes", () {
    expect(_label(5, "OT"), "2OT");
    expect(_label(7, "OT"), "4OT");
  });

  test("names the shootout SO", () {
    expect(_label(5, "SO"), "SO");
  });
}
