import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "skater_leader_pair.freezed.dart";
part "skater_leader_pair.g.dart";

/// Each team's leader in one category.
@freezed
@JsonSerializable()
class const SkaterLeaderPair({
  /// `points`, `goals` or `assists`.
  final String category = "",
  final MatchupPlayer awayLeader = const MatchupPlayer(),
  final MatchupPlayer homeLeader = const MatchupPlayer(),
}) with _$SkaterLeaderPair {
  factory fromJson(Map<String, dynamic> json) =>
      _$SkaterLeaderPairFromJson(json);

  Map<String, dynamic> toJson() => _$SkaterLeaderPairToJson(this);
}
