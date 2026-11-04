import "package:freezed_annotation/freezed_annotation.dart";

part "localized_name.freezed.dart";
part "localized_name.g.dart";

@freezed
@JsonSerializable()
class const LocalizedName({@JsonKey(name: "default") final String value = ""})
    with _$LocalizedName {
  factory fromJson(Map<String, dynamic> json) => _$LocalizedNameFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedNameToJson(this);
}
