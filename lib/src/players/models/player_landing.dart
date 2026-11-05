import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "package:nhl_app/src/core/core.dart";
import "package:nhl_app/src/players/players.dart";

part "player_landing.freezed.dart";
part "player_landing.g.dart";

/// Response of `GET /player/{playerId}/landing`.
@freezed
@JsonSerializable()
class const PlayerLanding({
  final int playerId = 0,
  final bool isActive = false,
  final int currentTeamId = 0,
  final String currentTeamAbbrev = "",
  final LocalizedName fullTeamName = const LocalizedName(),
  final LocalizedName teamCommonName = const LocalizedName(),
  final LocalizedName teamPlaceNameWithPreposition = const LocalizedName(),
  final LocalizedName firstName = const LocalizedName(),
  final LocalizedName lastName = const LocalizedName(),
  final String teamLogo = "",
  final int sweaterNumber = 0,

  /// `C`, `L`, `R`, `D` or `G`.
  final String position = "",
  final String headshot = "",
  final String heroImage = "",
  final int heightInInches = 0,
  final int heightInCentimeters = 0,
  final int weightInPounds = 0,
  final int weightInKilograms = 0,
  final DateTime? birthDate,
  final LocalizedName birthCity = const LocalizedName(),
  final LocalizedName birthStateProvince = const LocalizedName(),
  final String birthCountry = "",
  final String shootsCatches = "",
  final DraftDetails draftDetails = const DraftDetails(),
  final String playerSlug = "",
  final int inTop100AllTime = 0,
  final int inHHOF = 0,
  final FeaturedStats featuredStats = const FeaturedStats(),
  final CareerTotals careerTotals = const CareerTotals(),
  final String shopLink = "",
  final String twitterLink = "",
  final String watchLink = "",
  final IList<GameLog> last5Games = const IListConst([]),
  final IList<SeasonTotal> seasonTotals = const IListConst([]),
  final IList<Award> awards = const IListConst([]),
  final IList<Teammate> currentTeamRoster = const IListConst([]),
}) with _$PlayerLanding {
  factory fromJson(Map<String, dynamic> json) => _$PlayerLandingFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerLandingToJson(this);
}
