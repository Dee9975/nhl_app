import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";
import "package:nhl_app/src/schedule/schedule.dart";
import "package:nhl_app/src/teams/teams.dart";

/// Retry policy that never retries, so a failing provider settles on its
/// error at once instead of backing off.
Duration? noRetry(int retryCount, Object error) => null;

class FakeTeamsRepository implements TeamsRepository {
  FakeTeamsRepository({this.standings = const Ok(IListConst([]))});

  Result<IList<TeamStanding>> standings;
  int standingsCalls = 0;

  @override
  Future<Result<IList<TeamStanding>>> getStandings([DateTime? date]) async {
    standingsCalls++;
    return standings;
  }

  @override
  Future<Result<RosterResponse>> getRoster(String abr) {
    throw UnimplementedError();
  }
}

class FakeLeadersRepository implements LeadersRepository {
  FakeLeadersRepository({
    this.skaters = const Ok(SkaterLeadersResponse()),
    this.goalies = const Ok(GoalieLeadersResponse()),
  });

  Result<SkaterLeadersResponse> skaters;
  Result<GoalieLeadersResponse> goalies;
  int skaterCalls = 0;
  int goalieCalls = 0;

  @override
  Future<Result<SkaterLeadersResponse>> getCurrentSkaterLeaders({
    Iterable<SkaterLeaderCategory> categories = const [],
    int? limit,
  }) async {
    skaterCalls++;
    return skaters;
  }

  @override
  Future<Result<GoalieLeadersResponse>> getCurrentGoalieLeaders({
    Iterable<GoalieLeaderCategory> categories = const [],
    int? limit,
  }) async {
    goalieCalls++;
    return goalies;
  }
}

class FakeScheduleRepository implements ScheduleRepository {
  FakeScheduleRepository({this.schedule = const Ok(ScheduleResponse())});

  Result<ScheduleResponse> schedule;
  int calls = 0;

  @override
  Future<Result<ScheduleResponse>> getScheduleNow() async {
    calls++;
    return schedule;
  }
}

class FakeGameCenterRepository implements GameCenterRepository {
  FakeGameCenterRepository({
    this.landing = const Ok(GameLanding()),
    this.rightRail = const Ok(GameRightRail()),
  });

  Result<GameLanding> landing;
  Result<GameRightRail> rightRail;
  int landingCalls = 0;

  @override
  Future<Result<GameLanding>> getLanding(int gameId) async {
    landingCalls++;
    return landing;
  }

  @override
  Future<Result<GameRightRail>> getRightRail(int gameId) async {
    return rightRail;
  }
}
