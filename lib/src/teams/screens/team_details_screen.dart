import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

class const TeamDetailsScreen({super.key, required final TeamStanding standing})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rosterState = ref.watch(rosterProvider(standing.teamAbbrev.value));

    return Scaffold(
      body: SafeArea(
        child: switch (rosterState) {
          AsyncValue(:final Object error) => ErrorView(
            error: error,
            onRetry: () {
              ref.invalidate(rosterProvider(standing.teamAbbrev.value));
            },
          ),
          AsyncValue(:final RosterResponse value) => CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: TeamHeaderDelegate(standing: standing),
              ),
              SliverToBoxAdapter(child: TeamStats(standing: standing)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
                  child: Text(
                    "Roster",
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: .bold),
                  ),
                ),
              ),
              PlayerSection(title: "Forwards", players: value.forwards),
              PlayerSection(title: "Defensemen", players: value.defensemen),
              PlayerSection(title: "Goalies", players: value.goalies),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
