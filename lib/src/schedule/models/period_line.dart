import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "period_line.freezed.dart";
part "period_line.g.dart";

/// Away and home values for one period, e.g. goals or shots.
@freezed
@JsonSerializable()
class const PeriodLine({
  final PeriodDescriptor periodDescriptor = const PeriodDescriptor(),
  final int away = 0,
  final int home = 0,
}) with _$PeriodLine {
  factory fromJson(Map<String, dynamic> json) => _$PeriodLineFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodLineToJson(this);
}
