import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

/// Horizontally scrolling chips, one per category of the selected group
/// (skaters or goalies). Tapping one selects it in [leadersCategoryProvider].
class const LeaderCategoryChips({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LeaderCategory selected = ref.watch(leadersCategoryProvider);
    final List<LeaderCategory> categories = switch (selected) {
      SkaterLeaderCategory() => SkaterLeaderCategory.values,
      GoalieLeaderCategory() => GoalieLeaderCategory.values,
    };

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: .horizontal,
        padding: const .symmetric(horizontal: spaceXL, vertical: spaceMD),
        itemBuilder: (context, i) {
          final LeaderCategory category = categories[i];

          return ChoiceChip(
            label: Text(_label(category)),
            selected: category == selected,
            onSelected: (_) {
              ref.read(leadersCategoryProvider.notifier).select(category);
            },
          );
        },
        separatorBuilder: (context, i) => const SizedBox(width: spaceMD),
        itemCount: categories.length,
      ),
    );
  }

  String _label(LeaderCategory category) {
    return switch (category) {
      SkaterLeaderCategory.goals => "Goals",
      SkaterLeaderCategory.assists => "Assists",
      SkaterLeaderCategory.points => "Points",
      SkaterLeaderCategory.plusMinus => "+/-",
      SkaterLeaderCategory.goalsPp => "PP goals",
      SkaterLeaderCategory.goalsSh => "SH goals",
      SkaterLeaderCategory.penaltyMins => "PIM",
      SkaterLeaderCategory.faceoffLeaders => "Faceoff %",
      SkaterLeaderCategory.toi => "TOI",
      GoalieLeaderCategory.wins => "Wins",
      GoalieLeaderCategory.shutouts => "Shutouts",
      GoalieLeaderCategory.savePctg => "Save %",
      GoalieLeaderCategory.goalsAgainstAverage => "GAA",
    };
  }
}
