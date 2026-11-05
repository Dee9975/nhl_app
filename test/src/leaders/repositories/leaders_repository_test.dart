import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/leaders/leaders.dart";

/// Records the query each call was made with.
class _RecordingLeadersApi implements LeadersApi {
  String? categories;
  int? limit;
  bool fail = false;

  @override
  Future<SkaterLeadersResponse> getCurrentSkaterLeaders({
    String? categories,
    int? limit,
  }) async {
    this.categories = categories;
    this.limit = limit;
    if (fail) {
      throw const FormatException("bad payload");
    }
    return const SkaterLeadersResponse();
  }

  @override
  Future<GoalieLeadersResponse> getCurrentGoalieLeaders({
    String? categories,
    int? limit,
  }) async {
    this.categories = categories;
    this.limit = limit;
    return const GoalieLeadersResponse();
  }
}

void main() {
  late _RecordingLeadersApi api;
  late LeadersRepository repository;

  setUp(() {
    api = _RecordingLeadersApi();
    repository = LeadersRepository(api);
  });

  test("no categories leaves the filter off, for every category", () async {
    await repository.getCurrentSkaterLeaders();

    expect(api.categories, isNull);
    expect(api.limit, isNull);
  });

  test("joins skater categories with commas, using the API names", () async {
    await repository.getCurrentSkaterLeaders(
      categories: [SkaterLeaderCategory.goals, SkaterLeaderCategory.goalsPp],
      limit: 15,
    );

    expect(api.categories, "goals,goalsPp");
    expect(api.limit, 15);
  });

  test("joins goalie categories with commas, using the API names", () async {
    await repository.getCurrentGoalieLeaders(
      categories: [
        GoalieLeaderCategory.savePctg,
        GoalieLeaderCategory.goalsAgainstAverage,
      ],
    );

    expect(api.categories, "savePctg,goalsAgainstAverage");
  });

  test("returns an API failure as Err", () async {
    api.fail = true;

    expect(
      await repository.getCurrentSkaterLeaders(),
      isA<Err<SkaterLeadersResponse>>(),
    );
  });
}
