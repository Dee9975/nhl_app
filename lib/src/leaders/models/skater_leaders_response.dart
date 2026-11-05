import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/leaders/leaders.dart";

part "skater_leaders_response.freezed.dart";
part "skater_leaders_response.g.dart";

/// Response of `GET /skater-stats-leaders/current`, one leaderboard per
/// [SkaterLeaderCategory]. Categories that were not requested stay empty.
@freezed
@JsonSerializable()
class const SkaterLeadersResponse({
  final IList<StatLeader> goals = const IListConst([]),
  final IList<StatLeader> assists = const IListConst([]),
  final IList<StatLeader> points = const IListConst([]),
  final IList<StatLeader> plusMinus = const IListConst([]),
  final IList<StatLeader> goalsPp = const IListConst([]),
  final IList<StatLeader> goalsSh = const IListConst([]),
  final IList<StatLeader> penaltyMins = const IListConst([]),
  final IList<StatLeader> faceoffLeaders = const IListConst([]),
  final IList<StatLeader> toi = const IListConst([]),
}) with _$SkaterLeadersResponse {
  factory fromJson(Map<String, dynamic> json) =>
      _$SkaterLeadersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SkaterLeadersResponseToJson(this);

  /// The leaderboard for [category].
  IList<StatLeader> operator [](SkaterLeaderCategory category) {
    return switch (category) {
      .goals => goals,
      .assists => assists,
      .points => points,
      .plusMinus => plusMinus,
      .goalsPp => goalsPp,
      .goalsSh => goalsSh,
      .penaltyMins => penaltyMins,
      .faceoffLeaders => faceoffLeaders,
      .toi => toi,
    };
  }
}
