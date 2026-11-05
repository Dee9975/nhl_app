import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

class const PlayerDetailsScreen({super.key, required final int playerId})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider(playerId));

    return Scaffold(
      body: SafeArea(
        child: switch (playerState) {
          AsyncValue(:final Object error) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(playerProvider(playerId)),
          ),
          AsyncValue(:final PlayerLanding value) => CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PlayerHeaderDelegate(player: value),
              ),
              SliverToBoxAdapter(child: PlayerSummary(player: value)),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
