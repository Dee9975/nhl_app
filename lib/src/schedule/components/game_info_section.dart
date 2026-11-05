import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/schedule/schedule.dart";

/// When and where, TV, the season series and the officials.
class const GameInfoSection({
  super.key,
  required final GameLanding landing,
  required final GameRightRail rightRail,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(
      context,
    );
    final DateTime? start = landing.startTimeUTC?.toLocal();
    final GameOfficials officials = rightRail.officials;
    final String networks = landing.tvBroadcasts
        .map((broadcast) => broadcast.network.trim())
        .where((network) => network.isNotEmpty)
        .toSet()
        .join(", ");
    final String venue = [
      landing.venue.value,
      landing.venueLocation.value,
    ].where((part) => part.isNotEmpty).join(", ");
    final SeasonSeriesWins wins = rightRail.seasonSeriesWins;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: "Game info"),
        Padding(
          padding: const .symmetric(horizontal: spaceXL),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              if (start != null) ...[
                StatRow(
                  label: "Date",
                  value: localizations.formatFullDate(start),
                ),
                StatRow(
                  label: "Time",
                  value: localizations.formatTimeOfDay(
                    TimeOfDay.fromDateTime(start),
                    alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(
                      context,
                    ),
                  ),
                ),
              ],
              if (venue.isNotEmpty) StatRow(label: "Venue", value: venue),
              if (networks.isNotEmpty) StatRow(label: "TV", value: networks),
              if (officials.referees.isNotEmpty)
                StatRow(label: "Referees", value: _names(officials.referees)),
              if (officials.linesmen.isNotEmpty)
                StatRow(label: "Linesmen", value: _names(officials.linesmen)),
              if (officials.awayTeam.headCoach.value.isNotEmpty)
                StatRow(
                  label: "${landing.awayTeam.abbrev} coach",
                  value: officials.awayTeam.headCoach.value,
                ),
              if (officials.homeTeam.headCoach.value.isNotEmpty)
                StatRow(
                  label: "${landing.homeTeam.abbrev} coach",
                  value: officials.homeTeam.headCoach.value,
                ),
            ],
          ),
        ),
        if (rightRail.seasonSeries.isNotEmpty) ...[
          SectionHeader(
            title:
                "Season series · ${landing.awayTeam.abbrev} "
                "${wins.awayTeamWins} – ${wins.homeTeamWins} "
                "${landing.homeTeam.abbrev}",
          ),
          for (final SeriesGame game in rightRail.seasonSeries)
            _SeriesGameRow(game: game, isCurrent: game.id == landing.id),
        ],
      ],
    );
  }

  String _names(IList<GameOfficial> officials) {
    return officials.map((official) => official.fullName.value).join(", ");
  }
}

/// Date, both logos and the score or local start time of a series game.
class const _SeriesGameRow({
  required final SeriesGame game,
  required final bool isCurrent,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String date = switch (game.startTimeUTC) {
      null => "",
      final DateTime start => MaterialLocalizations.of(
        context,
      ).formatShortMonthDay(start.toLocal()),
    };

    return Padding(
      padding: const .symmetric(horizontal: spaceXL, vertical: spaceSM),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(
              date,
              style: AppTextStyles.paragraph3.copyWith(
                fontWeight: isCurrent ? .bold : null,
              ),
            ),
          ),
          TeamLogo(url: game.awayTeam.logo, size: 24),
          const SizedBox(width: spaceSM),
          Text(game.awayTeam.abbrev),
          Expanded(
            child: GameStatus(
              gameState: game.gameState,
              gameScheduleState: game.gameScheduleState,
              startTimeUTC: game.startTimeUTC,
              awayScore: game.awayTeam.score,
              homeScore: game.homeTeam.score,
              lastPeriodType: game.gameOutcome?.lastPeriodType ?? "",
              style: AppTextStyles.paragraph2Bold,
            ),
          ),
          Text(game.homeTeam.abbrev),
          const SizedBox(width: spaceSM),
          TeamLogo(url: game.homeTeam.logo, size: 24),
        ],
      ),
    );
  }
}
