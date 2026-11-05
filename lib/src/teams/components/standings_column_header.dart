import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// `GP W L OTL PTS` labels lined up with the columns of [TeamRow].
class const StandingsColumnHeader({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle style = AppTextStyles.paragraph3.copyWith(
      color: ref.textSecondary,
    );

    return Padding(
      padding: const .fromLTRB(spaceXL, 0, spaceXL, spaceSM),
      child: Row(
        children: [
          const Spacer(),
          for (final String label in ["GP", "W", "L", "OTL"])
            SizedBox(
              width: standingsStatWidth,
              child: Text(label, textAlign: .center, style: style),
            ),
          SizedBox(
            width: standingsPointsWidth,
            child: Text("PTS", textAlign: .end, style: style),
          ),
        ],
      ),
    );
  }
}
