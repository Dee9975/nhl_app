import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

part "leaders_repository_provider.g.dart";

@Riverpod(keepAlive: true)
LeadersRepository leadersRepository(Ref ref) =>
    LeadersRepository(LeadersApi(ref.watch(dioProvider)));
