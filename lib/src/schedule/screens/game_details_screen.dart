import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

class const GameDetailsScreen({super.key, required final int gameId})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameDetailsProvider(gameId));

    return Scaffold(
      body: SafeArea(
        child: switch (gameState) {
          AsyncValue(:final Object error) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(gameDetailsProvider(gameId)),
          ),
          AsyncValue(
            value: (:final GameLanding landing, :final GameRightRail rightRail),
          ) =>
            RefreshIndicator(
              onRefresh: () => ref.refresh(gameDetailsProvider(gameId).future),
              child: GameDetailsView(landing: landing, rightRail: rightRail),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
