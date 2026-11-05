import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";

part "team_game_stat.freezed.dart";
part "team_game_stat.g.dart";

/// One team stat for this game.
@freezed
@JsonSerializable()
class const TeamGameStat({
  /// e.g. `sog`, `faceoffWinningPctg`, `powerPlay`.
  final String category = "",

  /// An `int`, a fraction (`double`) or text such as `0/2`, depending on
  /// [category].
  final Object? awayValue,

  /// Same type as [awayValue].
  final Object? homeValue,
}) with _$TeamGameStat {
  factory fromJson(Map<String, dynamic> json) => _$TeamGameStatFromJson(json);

  Map<String, dynamic> toJson() => _$TeamGameStatToJson(this);

  /// Display name of [category], e.g. `sog` as `Shots`.
  String get label {
    return switch (category) {
      "sog" => "Shots",
      "faceoffWinningPctg" => "Faceoff %",
      "powerPlay" => "Power play",
      "powerPlayPctg" => "Power play %",
      "pim" => "Penalty minutes",
      "hits" => "Hits",
      "blockedShots" => "Blocked shots",
      "giveaways" => "Giveaways",
      "takeaways" => "Takeaways",
      final String other => other,
    };
  }

  /// [awayValue] as shown, e.g. `61.4%` for fractions.
  String get awayText => _format(awayValue);

  /// [homeValue] as shown, e.g. `61.4%` for fractions.
  String get homeText => _format(homeValue);

  /// Away team's share of the combined value, or null for text values or
  /// when both are zero.
  double? get awayShare {
    return switch ((awayValue, homeValue)) {
      (final num away, final num home) when away + home > 0 =>
        away / (away + home),
      _ => null,
    };
  }

  /// Fractions as `61.4%`, everything else as given.
  String _format(Object? value) {
    return switch (value) {
      // 0 and 1 arrive as int, so match num.
      final num fraction when category.endsWith("Pctg") => StatFormat.percent(
        fraction,
      ),
      null => "–",
      _ => "$value",
    };
  }
}
