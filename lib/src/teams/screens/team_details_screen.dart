import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

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
                delegate: CollapsingImageHeaderDelegate(
                  image: TeamLogo(url: standing.teamLogo),
                  title: standing.teamName.value,
                ),
              ),
              SliverToBoxAdapter(child: TeamStats(standing: standing)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
                  child: Text("Roster", style: AppTextStyles.title1Bold),
                ),
              ),
              PlayerSection(
                title: "Forwards",
                players: value.forwards,
                onPlayerTap: (player) => _openPlayer(context, player),
              ),
              PlayerSection(
                title: "Defensemen",
                players: value.defensemen,
                onPlayerTap: (player) => _openPlayer(context, player),
              ),
              PlayerSection(
                title: "Goalies",
                players: value.goalies,
                onPlayerTap: (player) => _openPlayer(context, player),
              ),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }

  void _openPlayer(BuildContext context, RosterPlayer player) {
    unawaited(context.push("/teams/player/${player.id}"));
  }
}
