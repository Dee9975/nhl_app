import "package:flutter_test/flutter_test.dart";

import "package:nhl_app/src/schedule/schedule.dart";

void main() {
  test("isOngoing is true only around and during play", () {
    const Map<GameState, bool> expected = {
      GameState.future: false,
      GameState.preGame: true,
      GameState.live: true,
      GameState.critical: true,
      GameState.finished: false,
      GameState.official: false,
      GameState.unknown: false,
    };

    expect(expected.keys, unorderedEquals(GameState.values));
    for (final GameState state in GameState.values) {
      expect(state.isOngoing, expected[state], reason: "$state");
    }
  });
}
