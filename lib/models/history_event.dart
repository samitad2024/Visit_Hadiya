/// Model for a historical period/event item in the timeline list.
class HistoryEvent {
  final String id;
  final String titleKey; // localization key
  final String subtitleKey; // localization key
  final String imageAsset; // local placeholder or network later
  final int order; // for sorting

  const HistoryEvent({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.imageAsset,
    required this.order,
  });
}
