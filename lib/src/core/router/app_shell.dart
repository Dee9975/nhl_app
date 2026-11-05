import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// Bottom navigation bar around the current tab's screen.
///
/// Each tab is a branch of a [StatefulShellRoute], so it keeps its own
/// navigation stack when the user switches tabs.
class const AppShell({
  super.key,
  required final StatefulNavigationShell navigationShell,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTabSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: "Teams",
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            selectedIcon: Icon(Icons.leaderboard),
            label: "Leaders",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  /// Switches tab. Tapping the current tab again pops it back to its root.
  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
