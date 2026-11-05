import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

/// The player's action shot cropped to fill. Falls back to their whole
/// headshot when there is no action shot or it fails to load, and to a
/// person icon when neither loads.
class const PlayerPhoto({super.key, required final PlayerLanding player})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget placeholder = FittedBox(
      child: Icon(Icons.person, color: ref.textSecondary),
    );
    final Widget headshot = switch (player.headshot) {
      "" => placeholder,
      final String url => Image.network(
        url,
        fit: BoxFit.contain,
        alignment: .topCenter,
        errorBuilder: (context, error, stackTrace) => placeholder,
      ),
    };

    return switch (player.heroImage) {
      "" => headshot,
      final String url => Image.network(
        url,
        fit: BoxFit.cover,
        alignment: .topCenter,
        errorBuilder: (context, error, stackTrace) => headshot,
      ),
    };
  }
}
