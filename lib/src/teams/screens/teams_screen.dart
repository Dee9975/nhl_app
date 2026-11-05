import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

class const TeamsScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsState = ref.watch(teamsProvider);

    return Scaffold(
      body: switch (teamsState) {
        AsyncValue(:final Object error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(teamsProvider),
        ),
        AsyncValue(:final IList<TeamStanding> value) => ListView.separated(
          itemBuilder: (context, i) {
            final standing = value[i];

            return TeamRow(
              standing: standing,
              onTap: () {
                unawaited(
                  context.push(
                    "/teams/team/${standing.teamAbbrev.value}",
                    extra: standing,
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, i) {
            return const Divider(height: 1);
          },
          itemCount: value.length,
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
