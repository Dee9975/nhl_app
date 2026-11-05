import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";

/// Pinned header that collapses from an [image] banner to a toolbar-height
/// bar. The [title] moves from the bottom-left to beside the back button as
/// the header collapses, and the image fades out.
class const CollapsingImageHeaderDelegate({
  required final Widget image,
  required final String title,
  final double expandedHeight = 180,
}) extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double fontSize = AppTextStyles.title2Bold.fontSize!;
    // 0 when fully expanded, 1 when collapsed.
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);

    // Delegates have no ref; Consumer provides one for the themed colours.
    return Consumer(
      builder: (context, ref, child) => Material(
        color: ref.surface,
        elevation: overlapsContent ? 3 : 0,
        child: Stack(
          fit: .expand,
          children: [
            Opacity(
              opacity: 1 - t,
              child: Stack(
                fit: .expand,
                children: [
                  image,
                  // Fades the image into the surface behind the title.
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        stops: const [0.4, 1],
                        colors: [ref.surface.withValues(alpha: 0), ref.surface],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: .only(
                left:
                    lerpDouble(spaceXL, kToolbarHeight + spaceXL, t) ?? spaceXL,
                right: spaceXL,
                bottom: lerpDouble(spaceXL, 0, t) ?? spaceXL,
              ),
              child: Align(
                alignment:
                    Alignment.lerp(.bottomLeft, .centerLeft, t) ?? .bottomLeft,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: AppTextStyles.title2Bold.copyWith(
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
      ),
    );
  }

  @override
  bool shouldRebuild(CollapsingImageHeaderDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.image != image ||
        oldDelegate.expandedHeight != expandedHeight;
  }
}
