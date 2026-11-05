import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// A day's header, pinned while its games scroll, plus one row per game.
class const GameDaySection({
  super.key,
  required final GameDay day,
  final ValueChanged<ScheduleGame>? onGameTap,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String title = switch (day.date) {
      null => day.dayAbbrev,
      final DateTime date => MaterialLocalizations.of(
        context,
      ).formatMediumDate(date).toUpperCase(),
    };

    return SliverMainAxisGroup(
      slivers: [
        PinnedHeaderSliver(
          child: ColoredBox(
            color: ref.surface,
            child: SectionHeader(title: title, count: day.numberOfGames),
          ),
        ),
        SliverList.separated(
          separatorBuilder: (context, i) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final ScheduleGame game = day.games[i];

            return ScheduleGameRow(
              game: game,
              onTap: switch (onGameTap) {
                null => null,
                final ValueChanged<ScheduleGame> onTap => () => onTap(game),
              },
            );
          },
          itemCount: day.games.length,
        ),
      ],
    );
  }
}
