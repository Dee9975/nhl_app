import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

class const LeadersScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadersState = ref.watch(leadersProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const Padding(
              padding: .fromLTRB(spaceXL, spaceMD, spaceXL, 0),
              child: Text("Leaders", style: AppTextStyles.title1Bold),
            ),
            const LeaderGroupToggle(),
            const LeaderCategoryChips(),
            // While a new category loads the old list stays visible, so show
            // progress in place of the divider. Both are 2 px tall.
            switch (leadersState) {
              AsyncValue(isLoading: true, hasValue: true) =>
                const LinearProgressIndicator(minHeight: 2),
              _ => const Divider(height: 2),
            },
            const Expanded(child: LeadersList()),
          ],
        ),
      ),
    );
  }
}
