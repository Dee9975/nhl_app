import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

part "teams_repository_provider.g.dart";

@Riverpod(keepAlive: true)
TeamsRepository teamsRepository(Ref ref) =>
    TeamsRepository(TeamsApi(ref.watch(dioProvider)));
