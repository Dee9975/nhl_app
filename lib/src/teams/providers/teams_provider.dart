import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/teams/teams.dart";

part "teams_provider.g.dart";

@riverpod
Future<IList<TeamStanding>> teams(Ref ref) async {
  final repo = ref.watch(teamsRepositoryProvider);

  final Result<IList<TeamStanding>> result = await repo.getStandings();
  return switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}
