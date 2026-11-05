import "package:freezed_annotation/freezed_annotation.dart";

part "tv_broadcast.freezed.dart";
part "tv_broadcast.g.dart";

@freezed
@JsonSerializable()
class const TvBroadcast({
  final int id = 0,

  /// `H` home, `A` away or `N` national.
  final String market = "",
  final String countryCode = "",
  final String network = "",
  final int sequenceNumber = 0,
}) with _$TvBroadcast {
  factory fromJson(Map<String, dynamic> json) => _$TvBroadcastFromJson(json);

  Map<String, dynamic> toJson() => _$TvBroadcastToJson(this);
}
