import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

class const TeamsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Padding(
              padding: .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
              child: Text("Standings", style: AppTextStyles.title1Bold),
            ),
            StandingsViewToggle(),
            SizedBox(height: spaceMD),
            Expanded(child: StandingsList()),
          ],
        ),
      ),
    );
  }
}
