import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

class const ScheduleRepository(final ScheduleApi _api) {
  /// Every game in the week starting today.
  Future<Result<ScheduleResponse>> getScheduleNow() {
    return Result.guard(_api.getScheduleNow());
  }
}
