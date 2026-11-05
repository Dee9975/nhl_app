import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:nhl_app/src/teams/teams.dart";

part "standings_view_provider.g.dart";

/// Whether the standings are shown by division or league-wide. Starts on
/// division.
@riverpod
class StandingsViewSelection extends _$StandingsViewSelection {
  @override
  StandingsView build() => .division;

  void select(StandingsView view) {
    state = view;
  }
}
