import "package:go_router/go_router.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/teams/teams.dart";

part "router.g.dart";

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const TeamsScreen(),
        routes: [
          GoRoute(
            path: "team/:abr",
            builder: (context, state) {
              // `extra` is lost on deep links and web refreshes, so fall back
              // to a standing holding only the abbreviation from the path.
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
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
