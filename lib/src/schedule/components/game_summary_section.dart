import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// Goals by period, the scoring timeline and the three stars.
class const GameSummarySection({
  super.key,
  required final GameLanding landing,
  required final GameRightRail rightRail,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameSummary summary = landing.summary ?? const GameSummary();
    final Linescore? linescore = rightRail.linescore;
    final bool hasGoals = summary.scoring.any((p) => p.goals.isNotEmpty);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: "Summary"),
        if (linescore != null)
          _LinescoreTable(landing: landing, linescore: linescore),
        if (!hasGoals)
          const Padding(
            padding: .all(spaceXL),
            child: Text("No goals yet", textAlign: .center),
          ),
        for (final PeriodScoring period in summary.scoring)
          if (period.goals.isNotEmpty) ...[
            Padding(
              padding: const .fromLTRB(spaceXL, spaceLG, spaceXL, spaceSM),
              child: Text(
                period.periodDescriptor.label,
                style: AppTextStyles.paragraph2Bold,
              ),
            ),
            for (final GoalEvent goal in period.goals)
              _GoalRow(goal: goal, landing: landing),
          ],
        if (summary.threeStars.isNotEmpty) ...[
          const SectionHeader(title: "Three stars"),
          for (final ThreeStar star in summary.threeStars) _StarRow(star: star),
        ],
      ],
    );
  }
}

/// Goals per period with a total column, one row per team.
class const _LinescoreTable({
  required final GameLanding landing,
  required final Linescore linescore,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle headStyle = AppTextStyles.paragraph3.copyWith(
      color: ref.textSecondary,
    );
    const TextStyle totalStyle = AppTextStyles.paragraph2Bold;

    return Padding(
      padding: const .symmetric(horizontal: spaceXL),
      child: Table(
        columnWidths: const {0: FlexColumnWidth()},
        defaultColumnWidth: const FixedColumnWidth(40),
        defaultVerticalAlignment: .middle,
        children: [
          TableRow(
            children: [
              const SizedBox.shrink(),
              for (final PeriodLine line in linescore.byPeriod)
                Text(
                  line.periodDescriptor.label,
                  textAlign: .center,
                  style: headStyle,
                ),
              Text("T", textAlign: .center, style: headStyle),
            ],
          ),
          for (final bool isHome in [false, true])
            TableRow(
              children: [
                Padding(
                  padding: const .symmetric(vertical: spaceSM),
                  child: Row(
                    children: [
                      TeamLogo(
                        url: isHome
                            ? landing.homeTeam.logo
                            : landing.awayTeam.logo,
                        size: 24,
                      ),
                      const SizedBox(width: spaceMD),
                      Text(
                        isHome
                            ? landing.homeTeam.abbrev
                            : landing.awayTeam.abbrev,
                      ),
                    ],
                  ),
                ),
                for (final PeriodLine line in linescore.byPeriod)
                  Text("${isHome ? line.home : line.away}", textAlign: .center),
                Text(
                  "${isHome ? linescore.totals.home : linescore.totals.away}",
                  textAlign: .center,
                  style: totalStyle,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Time, team, scorer with assists, strength tag and score after the goal.
class const _GoalRow({
  required final GoalEvent goal,
  required final GameLanding landing,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String logo = goal.isHome
        ? landing.homeTeam.logo
        : landing.awayTeam.logo;
    final String tag = _tag();

    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: 48,
            child: Text(goal.timeInPeriod, style: AppTextStyles.paragraph3),
          ),
          TeamLogo(url: logo, size: 24),
          const SizedBox(width: spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "${goal.name.value} (${goal.goalsToDate})",
                  style: AppTextStyles.paragraph2Bold,
                ),
                Text(
                  _assists(),
                  style: AppTextStyles.paragraph3.copyWith(
                    color: ref.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (tag.isNotEmpty)
            Padding(
              padding: const .only(left: spaceMD),
              child: Text(tag, style: AppTextStyles.paragraph3Bold),
            ),
          SizedBox(
            width: 48,
            child: Text(
              "${goal.awayScore}-${goal.homeScore}",
              textAlign: .end,
              style: AppTextStyles.paragraph3,
            ),
          ),
        ],
      ),
    );
  }

  /// `PP`, `SH`, `EN` or empty for even strength.
  String _tag() {
    return switch ((goal.strength, goal.goalModifier)) {
      (_, "empty-net") => "EN",
      ("pp", _) => "PP",
      ("sh", _) => "SH",
      _ => "",
    };
  }

  /// e.g. `N. Kucherov (11), V. Hedman (6)`, or `Unassisted`.
  String _assists() {
    return switch (goal.assists.isEmpty) {
      true => "Unassisted",
      false =>
        goal.assists
            .map((a) => "${a.name.value} (${a.assistsToDate})")
            .join(", "),
    };
  }
}

/// Star rank, headshot, name, team and the line that earned the star.
class const _StarRow({required final ThreeStar star}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text("★${star.star}", style: AppTextStyles.title3Bold),
          ),
          PlayerHeadshot(url: star.headshot, radius: 20),
          const SizedBox(width: spaceLG),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(star.name.value, style: AppTextStyles.paragraph2Bold),
                Text(
                  "${star.teamAbbrev} · ${star.position} · #${star.sweaterNo}",
                  style: AppTextStyles.paragraph3.copyWith(
                    color: ref.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(_line(), style: AppTextStyles.paragraph2),
        ],
      ),
    );
  }

  /// `1G 3A` for skaters, `.923 SV%` for goalies.
  String _line() {
    return switch (star.position) {
      "G" => "${StatFormat.savePct(star.savePctg)} SV%",
      _ => "${star.goals}G ${star.assists}A",
    };
  }
}
