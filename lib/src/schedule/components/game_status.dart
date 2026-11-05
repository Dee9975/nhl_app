import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// Local start time before a game, score and state once it has started, or
/// why it will not be played. Shared by schedule rows and the game header.
class const GameStatus({
  super.key,
  required final GameState gameState,
  final String gameScheduleState = "",
  final DateTime? startTimeUTC,
  final int? awayScore,
  final int? homeScore,

  /// `REG`, `OT` or `SO` for the period a finished game ended in.
  final String lastPeriodType = "",

  /// Shown after `LIVE` while the game is on, e.g. `2nd 12:34`.
  final String clockLabel = "",

  /// Text style of the time or score; defaults to [AppTextStyles.title3Bold].
  final TextStyle? style,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle mainStyle = style ?? AppTextStyles.title3Bold;
    final TextStyle labelStyle = AppTextStyles.paragraph3.copyWith(
      color: ref.textSecondary,
    );
    final String score = "${_goals(awayScore)} – ${_goals(homeScore)}";

    final (String main, String label, Color? labelColor) = switch ((
      gameScheduleState,
      gameState,
    )) {
      ("PPD", _) => ("Postponed", "", null),
      ("CNCL", _) => ("Cancelled", "", null),
      (_, .live || .critical) => (score, _liveLabel(), ref.error),
      (_, .finished || .official) => (score, _finalLabel(), null),
      (_, .future || .preGame || .unknown) => (_startTime(context), "", null),
    };

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 96),
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(main, style: mainStyle),
          if (label.isNotEmpty)
            Text(label, style: labelStyle.copyWith(color: labelColor)),
        ],
      ),
    );
  }

  /// Start time in the device's time zone, locale and 12/24 h setting.
  String _startTime(BuildContext context) {
    final DateTime? start = startTimeUTC;
    if (start == null) {
      return "TBD";
    }

    return MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(start.toLocal()),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
  }

  /// `LIVE`, or `LIVE · 2nd 12:34` with a clock.
  String _liveLabel() {
    return switch (clockLabel) {
      "" => "LIVE",
      _ => "LIVE · $clockLabel",
    };
  }

  /// `Final`, `Final/OT` or `Final/SO`.
  String _finalLabel() {
    return switch (lastPeriodType) {
      "OT" => "Final/OT",
      "SO" => "Final/SO",
      _ => "Final",
    };
  }

  String _goals(int? goals) {
    return switch (goals) {
      null => "–",
      _ => "$goals",
    };
  }
}
