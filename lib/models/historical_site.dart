import 'package:flutter/foundation.dart';

@immutable
class HistoricalSite {
  final String id;
  final String nameKey; // localization key
  final String subtitleKey; // localization key
  final String imageAsset; // local asset path for thumbnail/hero
  final double? latitude; // optional for future map integration
  final double? longitude; // optional for future map integration

  const HistoricalSite({
    required this.id,
    required this.nameKey,
    required this.subtitleKey,
    required this.imageAsset,
    this.latitude,
    this.longitude,
  });
}
