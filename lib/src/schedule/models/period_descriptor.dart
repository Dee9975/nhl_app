import "package:freezed_annotation/freezed_annotation.dart";

part "period_descriptor.freezed.dart";
part "period_descriptor.g.dart";

@freezed
@JsonSerializable()
class const PeriodDescriptor({
  final int number = 0,

  /// `REG`, `OT` or `SO`.
  final String periodType = "",
  final int maxRegulationPeriods = 0,
}) with _$PeriodDescriptor {
  factory fromJson(Map<String, dynamic> json) =>
      _$PeriodDescriptorFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodDescriptorToJson(this);

  /// Short name: `1st`, `2nd`, `3rd`, `OT`, `2OT` (playoffs), `SO`.
  String get label {
    final int overtime = number - maxRegulationPeriods;

    return switch (periodType) {
      "SO" => "SO",
      "OT" when overtime > 1 => "${overtime}OT",
      "OT" => "OT",
      _ => switch (number) {
        1 => "1st",
        2 => "2nd",
        3 => "3rd",
        _ => "${number}th",
      },
    };
  }
}
