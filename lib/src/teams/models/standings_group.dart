import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "package:nhl_app/src/teams/teams.dart";

/// A team with its rank in the group it is shown in.
typedef RankedTeam = ({int rank, TeamStanding standing});

/// A named group of ranked teams, e.g. a division or the whole league.
typedef StandingsGroup = ({String name, IList<RankedTeam> teams});

/// Groups for one [StandingsView], together with that view.
typedef Standings = ({StandingsView view, IList<StandingsGroup> groups});
