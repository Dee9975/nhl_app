import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Full-width Division | League toggle for [standingsViewSelectionProvider].
class const StandingsViewToggle({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
      child: SegmentedButton<StandingsView>(
        segments: const [
          ButtonSegment(value: .division, label: Text("Division")),
          ButtonSegment(value: .league, label: Text("League")),
        ],
        selected: {ref.watch(standingsViewSelectionProvider)},
        onSelectionChanged: (selection) {
          ref
              .read(standingsViewSelectionProvider.notifier)
              .select(selection.first);
        },
      ),
    );
  }
}
