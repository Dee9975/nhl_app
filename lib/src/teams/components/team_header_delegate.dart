import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Pinned header that collapses from a logo banner to a toolbar-height bar.
///
/// The title moves from the bottom-left (16 px padding) to beside the back
/// button as the header collapses.
class const TeamHeaderDelegate({required final TeamStanding standing})
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => 180;

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
                SvgPicture.network(standing.teamLogo),
                // Fades the logo into the surface behind the title.
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
                standing.teamName.value,
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

  @override
  bool shouldRebuild(TeamHeaderDelegate oldDelegate) {
    return oldDelegate.standing != standing;
  }
}
