import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// One roster player: headshot, name, position and sweater number.
class const PlayerRow({
  super.key,
  required final RosterPlayer player,
  final VoidCallback? onTap,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = "${player.firstName.value} ${player.lastName.value}";

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .symmetric(horizontal: spaceXL, vertical: spaceMD),
        child: Row(
          children: [
            PlayerHeadshot(url: player.headshot, radius: 28),
            const SizedBox(width: spaceXL),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: AppTextStyles.title3Bold,
                  ),
                  Text(
                    _details(),
                    style: AppTextStyles.paragraph3.copyWith(
                      color: ref.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text("#${player.sweaterNumber}", style: AppTextStyles.title2Bold),
          ],
        ),
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
