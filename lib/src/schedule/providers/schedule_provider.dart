import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "schedule_provider.g.dart";

/// Every game in the week starting today.
///
/// While a game is about to start or in progress it refetches every
/// [liveRefreshInterval], so scores and clocks stay current.
@riverpod
Future<ScheduleResponse> schedule(Ref ref) async {
  final repo = ref.watch(scheduleRepositoryProvider);

  final Result<ScheduleResponse> result = await repo.getScheduleNow();
  final ScheduleResponse schedule = switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };

  final bool anyLive = schedule.gameWeek
      .expand((day) => day.games)
      .any((game) => game.gameState.isOngoing);
  if (anyLive) {
    final Timer timer = Timer(liveRefreshInterval, ref.invalidateSelf);
    ref.onDispose(timer.cancel);
  }

  return schedule;
}
