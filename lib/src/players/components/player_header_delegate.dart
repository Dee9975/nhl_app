import "dart:ui";

import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

/// Pinned header that collapses from a photo banner to a toolbar-height bar.
///
/// Shows the action shot ([PlayerLanding.heroImage]), or the headshot when
/// there is none. The name moves from the bottom-left (16 px padding) to
/// beside the back button as the header collapses.
class const PlayerHeaderDelegate({required final PlayerLanding player})
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => 260;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!;
    final double fontSize = titleStyle.fontSize ?? 22;
    // 0 when fully expanded, 1 when collapsed.
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    final String name = "${player.firstName.value} ${player.lastName.value}";

    return Material(
      color: colorScheme.surface,
      elevation: overlapsContent ? 3 : 0,
      child: Stack(
        fit: .expand,
        children: [
          Opacity(
            opacity: 1 - t,
            child: Stack(
              fit: .expand,
              children: [
                _photo(),
                // Fades the photo into the surface behind the name.
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: .topCenter,
                      end: .bottomCenter,
                      stops: const [0.4, 1],
                      colors: [
                        colorScheme.surface.withValues(alpha: 0),
                        colorScheme.surface,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: .only(
              left: lerpDouble(spaceXL, kToolbarHeight + spaceXL, t) ?? spaceXL,
              right: spaceXL,
              bottom: lerpDouble(spaceXL, 0, t) ?? spaceXL,
            ),
            child: Align(
              alignment:
                  Alignment.lerp(.bottomLeft, .centerLeft, t) ?? .bottomLeft,
              child: Text(
                name,
                maxLines: 1,
                overflow: .ellipsis,
                style: titleStyle.copyWith(
                  fontWeight: .bold,
                  fontSize: lerpDouble(fontSize * 1.5, fontSize, t),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: Center(child: BackButton()),
          ),
        ],
      ),
    );
  }

  /// Action shot cropped to fill, or the whole headshot, or nothing.
  Widget _photo() {
    final (String url, BoxFit fit) = switch (player.heroImage) {
      "" => (player.headshot, BoxFit.contain),
      final String hero => (hero, BoxFit.cover),
    };

    return switch (url) {
      "" => const SizedBox.shrink(),
      _ => Image.network(
        url,
        fit: fit,
        alignment: .topCenter,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    };
  }

  @override
  bool shouldRebuild(PlayerHeaderDelegate oldDelegate) {
    return oldDelegate.player != player;
  }
}
