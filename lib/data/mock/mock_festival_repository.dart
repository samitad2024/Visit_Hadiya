import '../../models/festival_event.dart';

class MockFestivalRepository {
  List<FestivalEvent> fetchEvents() {
    return const [
      FestivalEvent(
        id: 'hossana',
        titleKey: 'festival_hossana',
        date: DateTime(2024, 10, 20),
      ),
      FestivalEvent(
        id: 'new_year',
        titleKey: 'festival_new_year',
        date: DateTime(2024, 11, 5),
      ),
    ];
  }
}
