import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

part "schedule_repository_provider.g.dart";

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(Ref ref) =>
    ScheduleRepository(ScheduleApi(ref.watch(dioProvider)));
