import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

part "players_repository_provider.g.dart";

@Riverpod(keepAlive: true)
PlayersRepository playersRepository(Ref ref) =>
    PlayersRepository(PlayersApi(ref.watch(dioProvider)));
