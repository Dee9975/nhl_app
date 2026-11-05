import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

/// One standings row: team logo, name and points.
class const TeamRow({
  super.key,
  required final TeamStanding standing,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .all(spaceMD),
        child: Row(
          children: [
            SvgPicture.network(standing.teamLogo, width: 40, height: 40),
            const SizedBox(width: spaceXL),
            Text(standing.teamName.value),
            const Spacer(),
            Text(standing.points.toString()),
          ],
        ),
      ),
    );
  }
}
