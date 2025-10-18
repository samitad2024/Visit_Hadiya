import '../../models/history_event.dart';

class MockHistoryRepository {
  List<HistoryEvent> fetchEvents() {
    return const [
      HistoryEvent(
        id: 'kelalamo',
        titleKey: 'history_pre_state_title',
        subtitleKey: 'history_pre_state_sub',
        imageAsset: 'assets/images/kelalamo.png',
        order: 1,
      ),
      HistoryEvent(
        id: 'mechefera',
        titleKey: 'history_sultanate_title',
        subtitleKey: 'history_sultanate_sub',
        imageAsset: 'assets/images/mechefera.png',
        order: 2,
      ),
      HistoryEvent(
        id: 'hadiya_nafara',
        titleKey: 'history_adal_title',
        subtitleKey: 'history_adal_sub',
        imageAsset: 'assets/images/hadiy_nafara_two.png',
        order: 3,
      ),
      HistoryEvent(
        id: 'hadiya_nefera',
        titleKey: 'history_modern_title',
        subtitleKey: 'history_modern_sub',
        imageAsset: 'assets/images/hadiy_nefera.png',
        order: 4,
      ),
      HistoryEvent(
        id: 'kelalamo_heritage',
        titleKey: 'history_contemporary_title',
        subtitleKey: 'history_contemporary_sub',
        imageAsset: 'assets/images/kelalamo.png',
        order: 5,
      ),
    ];
  }
}
