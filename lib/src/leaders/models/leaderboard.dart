import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "package:nhl_app/src/leaders/leaders.dart";

/// One category's leaders, ranked, together with the category they belong to.
typedef Leaderboard = ({LeaderCategory category, IList<StatLeader> leaders});
