import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "game_center_repository_provider.g.dart";

@Riverpod(keepAlive: true)
GameCenterRepository gameCenterRepository(Ref ref) =>
    GameCenterRepository(GameCenterApi(ref.watch(dioProvider)));
