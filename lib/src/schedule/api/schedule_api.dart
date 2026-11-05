import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

import "package:nhl_app/src/schedule/schedule.dart";

part "schedule_api.g.dart";

@RestApi()
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String? baseUrl}) = _ScheduleApi;

  /// Every game in the week starting today.
  @GET("/schedule/now")
  Future<ScheduleResponse> getScheduleNow();
}
