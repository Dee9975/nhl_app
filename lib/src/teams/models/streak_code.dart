import "package:freezed_annotation/freezed_annotation.dart";

enum StreakCode {
  @JsonValue("W")
  win,
  @JsonValue("L")
  loss,
  @JsonValue("OT")
  overtimeLoss,
  unknown,
}
