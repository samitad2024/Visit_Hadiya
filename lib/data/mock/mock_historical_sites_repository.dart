import 'package:flutter/foundation.dart';

import '../../models/historical_site.dart';

@immutable
class MockHistoricalSitesRepository {
  const MockHistoricalSitesRepository();

  List<HistoricalSite> fetchSites() => const [
    HistoricalSite(
      id: 'chebera',
      nameKey: 'site_chebera_name',
      subtitleKey: 'site_chebera_sub',
      imageAsset: 'assets/images/chebera_churchura.jpg',
      latitude: 6.987,
      longitude: 36.778,
    ),
    HistoricalSite(
      id: 'wonchi',
      nameKey: 'site_wonchi_name',
      subtitleKey: 'site_wonchi_sub',
      imageAsset: 'assets/images/lake_wonchi.jpg',
      latitude: 8.777,
      longitude: 37.891,
    ),
    HistoricalSite(
      id: 'tiya',
      nameKey: 'site_tiya_name',
      subtitleKey: 'site_tiya_sub',
      imageAsset: 'assets/images/tiya_stones.jpg',
      latitude: 8.433,
      longitude: 38.616,
    ),
    HistoricalSite(
      id: 'adadi',
      nameKey: 'site_adadi_name',
      subtitleKey: 'site_adadi_sub',
      imageAsset: 'assets/images/adadi_mariam.jpg',
      latitude: 8.667,
      longitude: 38.408,
    ),
  ];
}
