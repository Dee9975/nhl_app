import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// Pinned scoreboard that collapses from big logos with the score or start
/// time to a toolbar-height bar reading e.g. `WPG 4 – 6 TBL`.
class const GameHeaderDelegate({required final GameLanding game})
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => 196;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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
            // Always laid out at full height and pinned to the bottom, so it
            // slides up under the clip as the header shrinks instead of being
            // squeezed.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: maxExtent,
              child: Opacity(
                opacity: 1 - t,
                child: Padding(
                  padding: const .fromLTRB(
                    spaceXL,
                    kToolbarHeight - spaceMD,
                    spaceXL,
                    spaceXL,
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _HeaderTeam(team: game.awayTeam)),
                      GameStatus(
                        gameState: game.gameState,
                        gameScheduleState: game.gameScheduleState,
                        startTimeUTC: game.startTimeUTC,
                        awayScore: game.awayTeam.score,
                        homeScore: game.homeTeam.score,
                        lastPeriodType: game.periodDescriptor.periodType,
                        clockLabel: _clockLabel(),
                        style: AppTextStyles.title1Bold,
                      ),
                      Expanded(child: _HeaderTeam(team: game.homeTeam)),
                    ],
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: t,
              child: Padding(
                padding: const .symmetric(horizontal: kToolbarHeight),
                child: Center(
                  child: Text(
                    _collapsedTitle(),
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: AppTextStyles.title2Bold.copyWith(
                      fontSize: lerpDouble(
                        0,
                        AppTextStyles.title2Bold.fontSize,
                        t,
                      ),
                    ),
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

  /// `2nd 12:34`, or `2nd INT` during the intermission after it.
  String _clockLabel() {
    final String period = game.periodDescriptor.label;
    return switch (game.clock.inIntermission) {
      true => "$period INT",
      false => "$period ${game.clock.timeRemaining}",
    };
  }

  /// `WPG 4 – 6 TBL` once started, `WPG @ TBL` before.
  String _collapsedTitle() {
    final String away = game.awayTeam.abbrev;
    final String home = game.homeTeam.abbrev;
    return switch ((game.awayTeam.score, game.homeTeam.score)) {
      (final int a, final int h) => "$away $a – $h $home",
      _ => "$away @ $home",
    };
  }

  @override
  bool shouldRebuild(GameHeaderDelegate oldDelegate) {
    return oldDelegate.game != game;
  }
}

class const _HeaderTeam({required final GameTeam team})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        TeamLogo(url: team.logo, size: 64),
        Text(team.abbrev, style: AppTextStyles.title3Bold),
        if (team.record.isNotEmpty)
          Text(team.record, style: AppTextStyles.paragraph3),
      ],
    );
  }
}
