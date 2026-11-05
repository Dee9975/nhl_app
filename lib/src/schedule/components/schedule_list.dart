import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// The week's games grouped by day, with error and loading states. Days
/// without games are left out. Pull down to refresh.
class const ScheduleList({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleState = ref.watch(scheduleProvider);

    return switch (scheduleState) {
      AsyncValue(:final Object error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(scheduleProvider),
      ),
      AsyncValue(:final ScheduleResponse value) => RefreshIndicator(
        onRefresh: () => ref.refresh(scheduleProvider.future),
        child: CustomScrollView(
          slivers: [
            for (final GameDay day in value.gameWeek)
              if (day.games.isNotEmpty)
                GameDaySection(
                  day: day,
                  onGameTap: (game) {
                    unawaited(context.push("/schedule/game/${game.id}"));
                  },
                ),
          ],
        ),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
