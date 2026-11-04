import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// One roster player: headshot, name, position and sweater number.
class const PlayerRow({super.key, required final RosterPlayer player})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String name = "${player.firstName.value} ${player.lastName.value}";

    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceMD),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundImage: switch (player.headshot) {
              "" => null,
              final String url => NetworkImage(url),
            },
            child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: spaceXL),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: textTheme.titleMedium?.copyWith(fontWeight: .w600),
                ),
                Text(
                  _details(),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "#${player.sweaterNumber}",
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: .bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Position and handedness, e.g. `Center · Shoots L`.
  String _details() {
    final String position = switch (player.positionCode) {
      "C" => "Center",
      "L" => "Left wing",
      "R" => "Right wing",
      "D" => "Defense",
      "G" => "Goalie",
      final String code => code,
    };
    final String verb = switch (player.positionCode) {
      "G" => "Catches",
      _ => "Shoots",
    };

    return switch (player.shootsCatches) {
      "" => position,
      final String hand => "$position · $verb $hand",
    };
  }
}
