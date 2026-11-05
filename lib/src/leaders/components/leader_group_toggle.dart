import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

/// Full-width Skaters | Goalies toggle. The group follows the selected
/// [leadersCategoryProvider].
class const LeaderGroupToggle({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LeaderGroup group = switch (ref.watch(leadersCategoryProvider)) {
      SkaterLeaderCategory() => .skaters,
      GoalieLeaderCategory() => .goalies,
    };

    return Padding(
      padding: const .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
      child: SegmentedButton<LeaderGroup>(
        segments: const [
          ButtonSegment(value: .skaters, label: Text("Skaters")),
          ButtonSegment(value: .goalies, label: Text("Goalies")),
        ],
        selected: {group},
        onSelectionChanged: (selection) {
          ref
              .read(leadersCategoryProvider.notifier)
              .selectGroup(selection.first);
        },
      ),
    );
  }
}
