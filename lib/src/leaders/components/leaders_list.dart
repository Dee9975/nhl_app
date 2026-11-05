import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

/// Ranked list of [leadersProvider], with error and loading states.
class const LeadersList({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadersState = ref.watch(leadersProvider);

    return switch (leadersState) {
      AsyncValue(:final Object error) => ErrorView(
        error: error,
        onRetry: () {
          // The failed request is in the cached group providers.
          ref
            ..invalidate(skaterLeadersProvider)
            ..invalidate(goalieLeadersProvider);
        },
      ),
      AsyncValue(
        value: (
          :final LeaderCategory category,
          :final IList<StatLeader> leaders,
        ),
      ) =>
        ListView.separated(
          // A new scroll view per category, so a new leaderboard starts at the
          // top. Keyed by the loaded category, so the old list keeps its
          // position while the next one loads.
          key: ValueKey(category),
          itemBuilder: (context, i) {
            final StatLeader leader = leaders[i];

            return LeaderRow(
              rank: i + 1,
              leader: leader,
              category: category,
              onTap: () {
                unawaited(context.push("/leaders/player/${leader.id}"));
              },
            );
          },
          separatorBuilder: (context, i) {
            // Lines up with the player name, past rank and headshot.
            return const Divider(
              height: 1,
              indent: spaceXL + leaderRankWidth + spaceMD + 56 + spaceXL,
            );
          },
          itemCount: leaders.length,
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
