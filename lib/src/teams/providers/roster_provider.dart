import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

part "roster_provider.g.dart";

/// Current roster for the team with abbreviation [abr] (e.g. `TOR`).
@riverpod
Future<RosterResponse> roster(Ref ref, String abr) async {
  final repo = ref.watch(teamsRepositoryProvider);

  final Result<RosterResponse> result = await repo.getRoster(abr);
  return switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}
