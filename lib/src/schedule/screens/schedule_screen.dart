import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

class const ScheduleScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Padding(
              padding: .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
              child: Text("Schedule", style: AppTextStyles.title1Bold),
            ),
            Expanded(child: ScheduleList()),
          ],
        ),
      ),
    );
  }
}
