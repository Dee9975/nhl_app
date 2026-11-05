import "package:go_router/go_router.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";
import "package:nhl_app/src/players/players.dart";
import "package:nhl_app/src/settings/settings.dart";
import "package:nhl_app/src/teams/teams.dart";

part "router.g.dart";

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = GoRouter(
    initialLocation: "/teams",
    routes: [
      // One branch per bottom navigation tab, in the order of the tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/teams",
                builder: (context, state) => const TeamsScreen(),
                routes: [
                  GoRoute(
                    path: "team/:abr",
                    builder: (context, state) {
                      // `extra` is lost on deep links and web refreshes, so
                      // fall back to a standing holding only the
                      // abbreviation from the path.
                      final TeamStanding standing = switch (state.extra) {
                        final TeamStanding standing => standing,
                        _ => TeamStanding(
                          teamAbbrev: LocalizedName(
                            value: state.pathParameters["abr"] ?? "",
                          ),
                        ),
                      };

                      return TeamDetailsScreen(standing: standing);
                    },
                  ),
                  GoRoute(
                    path: "player/:id",
                    builder: (context, state) {
                      final int playerId =
                          int.tryParse(state.pathParameters["id"] ?? "") ?? 0;

                      return PlayerDetailsScreen(playerId: playerId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/leaders",
                builder: (context, state) => const LeadersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
