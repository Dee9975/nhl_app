import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/settings/settings.dart";

class const SettingsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Padding(
              padding: .fromLTRB(spaceXL, spaceMD, spaceXL, spaceMD),
              child: Text("Settings", style: AppTextStyles.title1Bold),
            ),
            DarkThemeSwitch(),
          ],
        ),
      ),
    );
  }
}
