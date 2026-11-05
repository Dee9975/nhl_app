import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// One game: away team on the left, home team on the right, and the start
/// time (device local time) or the score in between.
class const ScheduleGameRow({
  super.key,
  required final ScheduleGame game,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .symmetric(horizontal: spaceXL, vertical: spaceLG),
        child: Row(
          children: [
            Expanded(child: _TeamSide(team: game.awayTeam, isHome: false)),
            GameStatus(
              gameState: game.gameState,
              gameScheduleState: game.gameScheduleState,
              startTimeUTC: game.startTimeUTC,
              awayScore: game.awayTeam.score,
              homeScore: game.homeTeam.score,
              lastPeriodType: game.gameOutcome?.lastPeriodType ?? "",
            ),
            Expanded(child: _TeamSide(team: game.homeTeam, isHome: true)),
          ],
        ),
      ),
    );
  }
}

/// Logo and abbreviation, mirrored for the home team so logos sit at the
/// outer edges.
class const _TeamSide({
  required final ScheduleTeam team,
  required final bool isHome,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      TeamLogo(url: team.logo, size: 40),
      const SizedBox(width: spaceMD),
      Text(team.abbrev, style: AppTextStyles.title3Bold),
    ];

    return Row(
      mainAxisAlignment: isHome ? .end : .start,
      children: isHome ? children.reversed.toList() : children,
    );
  }
}
