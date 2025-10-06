import '../../models/history_event.dart';

class MockHistoryRepository {
  List<HistoryEvent> fetchEvents() {
    return const [
      HistoryEvent(
        id: 'pre_state',
        titleKey: 'history_pre_state_title',
        subtitleKey: 'history_pre_state_sub',
        imageAsset: 'assets/images/placeholder_landscape.svg',
        order: 1,
      ),
      HistoryEvent(
        id: 'sultanate',
        titleKey: 'history_sultanate_title',
        subtitleKey: 'history_sultanate_sub',
        imageAsset: 'assets/images/placeholder_landscape.svg',
        order: 2,
      ),
      HistoryEvent(
        id: 'adal_war',
        titleKey: 'history_adal_title',
        subtitleKey: 'history_adal_sub',
        imageAsset: 'assets/images/placeholder_landscape.svg',
        order: 3,
      ),
      HistoryEvent(
        id: 'modern',
        titleKey: 'history_modern_title',
        subtitleKey: 'history_modern_sub',
        imageAsset: 'assets/images/placeholder_landscape.svg',
        order: 4,
      ),
      HistoryEvent(
        id: 'contemporary',
        titleKey: 'history_contemporary_title',
        subtitleKey: 'history_contemporary_sub',
        imageAsset: 'assets/images/placeholder_landscape.svg',
        order: 5,
      ),
    ];
  }
}
