import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// [standingsProvider] as pinned sections, with error and loading states.
class const StandingsList({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standingsState = ref.watch(standingsProvider);

    return switch (standingsState) {
      AsyncValue(:final Object error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(teamsProvider),
      ),
      AsyncValue(
        value: (:final StandingsView view, :final IList<StandingsGroup> groups),
      ) =>
        CustomScrollView(
          // A new scroll view per view, so switching starts at the top. Keyed
          // by the loaded view, so the old list is never shown in a new one.
          key: ValueKey(view),
          slivers: [
            for (final StandingsGroup group in groups)
              StandingsSection(
                group: group,
                onTeamTap: (standing) {
                  unawaited(
                    context.push(
                      "/teams/team/${standing.teamAbbrev.value}",
                      extra: standing,
                    ),
                  );
                },
              ),
          ],
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
